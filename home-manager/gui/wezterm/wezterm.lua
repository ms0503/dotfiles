local wezterm = require("wezterm")

return {
    audible_bell = "Disabled",
    check_for_updates = false,
    color_scheme = "MyTheme",
    font = wezterm.font_with_fallback({
        {
            family = "SauceCodePro Nerd Font",
            weight = "Regular",
        },
        {
            assume_emoji_presentation = true,
            family = "SauceCodePro Nerd Font",
            weight = "Regular",
        },
        {
            family = "Source Han Code JP",
            weight = "Regular",
        },
    }),
    hide_tab_bar_if_only_one_tab = true,
    use_fancy_tab_bar = false,
    use_ime = true,
    warn_about_missing_glyphs = false,
    window_frame = {
        font_size = 9.0,
    },
    window_padding = {
        bottom = 5,
        left = 10,
        right = 10,
        top = 5,
    },
}
