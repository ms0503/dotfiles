-- luacheck: std lua54
-- luacheck: push ignore Interest
-- luacheck: push ignore Link
-- luacheck: push ignore Log
-- luacheck: push ignore ObjectManager

local log = Log.open_topic('rtp-sender-restore-links')

local function split(str, delimiter)
    if delimiter == nil then
        return {}
    end
    local tbl = {}
    local i = 1
    for s in str:gmatch('([^' .. delimiter .. ']+)') do
        tbl[i] = s
        i = i + 1
    end
    return tbl
end

local sink_fl = split('@input_sink_fl@', ':')
local sink_fr = split('@input_sink_fr@', ':')

local ports = ObjectManager({
    Interest({
        type = 'port',
    }),
})
local links = ObjectManager({
    Interest({
        type = 'link',
    }),
})

local function find_port(node_name, port_name, port_dir)
    for port in ports:iterate() do
        local p = port.properties
        if
            p['node.name'] == node_name
            and p['port.name'] == port_name
            and p['port.direction'] == port_dir
        then
            return port
        end
    end
    return nil
end

local function link_exists(out_port, in_port)
    local out_node = out_port.properties['node.id']
    local out_id = out_port.properties['object.id']
    local in_node = in_port.properties['node.id']
    local in_id = in_port.properties['object.id']
    for link in links:iterate() do
        local p = link.properties
        if
            tonumber(p['link.output.node']) == tonumber(out_node)
            and tonumber(p['link.output.port']) == tonumber(out_id)
            and tonumber(p['link.input.node']) == tonumber(in_node)
            and tonumber(p['link.input.port']) == tonumber(in_id)
        then
            return true
        end
    end
    return false
end

local function create_link(out_port, in_port, out_name, in_name)
    local op = out_port.properties
    local ip = in_port.properties
    local link = Link('link-factory', {
        ['link.input.node'] = ip['node.id'],
        ['link.input.port'] = ip['object.id'],
        ['link.output.node'] = op['node.id'],
        ['link.output.port'] = op['object.id'],
        ['object.linger'] = true,
    })
    if link then
        link:activate(1)
        log:info('Created link: ' .. out_name .. ' -> ' .. in_name)
    else
        log:warning('Failed to create link')
    end
end

local function restore_links()
    local fl_out_port = find_port(sink_fl[1], sink_fl[2], 'out')
    local fr_out_port = find_port(sink_fr[1], sink_fr[2], 'out')
    local fl_in_port = find_port('@stream_node_name@', 'send_FL', 'in')
    local fr_in_port = find_port('@stream_node_name@', 'send_FR', 'in')
    if fl_out_port and fr_out_port and fl_in_port and fr_in_port then
        if not link_exists(fl_out_port, fl_in_port) then
            create_link(
                fl_out_port,
                fl_in_port,
                '@input_sink_fl@',
                '@stream_node_name@:send_FL'
            )
        end
        if not link_exists(fr_out_port, fr_in_port) then
            create_link(
                fr_out_port,
                fr_in_port,
                '@input_sink_fr@',
                '@stream_node_name@:send_FR'
            )
        end
    else
        log:info(
            'Waiting for ports: @input_sink_fl@ -> @stream_node_name@:send_FL, '
                .. '@input_sink_fr@ -> @stream_node_name@:send_FR'
        )
    end
end

ports:connect('object-added', restore_links)
links:connect('object-added', restore_links)
ports:activate()
links:activate()

-- luacheck: pop
-- luacheck: pop
-- luacheck: pop
-- luacheck: pop
