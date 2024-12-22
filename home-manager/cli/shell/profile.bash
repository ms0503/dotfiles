[[ -d /usr/lib/dotnet ]] && export DOTNET_ROOT=/usr/lib/dotnet

[[ ! -d $GOBIN && -d $HOME/go/bin ]] && export GOBIN=$HOME/go/bin

[[ -d ${XDG_DATA_HOME:-$HOME/.local/share}/JetBrains/Toolbox/scripts ]] && export PATH=${XDG_DATA_HOME:-$HOME/.local/share}/JetBrains/Toolbox/scripts${PATH:+:}$PATH
[[ -d /usr/local/cuda/extras/CUPTI/lib64 ]] && export LD_LIBRARY_PATH=$LD_LIBRARY_PATH${LD_LIBRARY_PATH:+:}/usr/local/cuda/extras/CUPTI/lib64
[[ -d $HOME/.local/share/gem/ruby/3.3.0/bin ]] && export PATH=$HOME/.local/share/gem/ruby/3.3.0/bin${PATH:+:}$PATH
[[ -d $GOBIN ]] && export PATH=$GOBIN${PATH:+:}$PATH
[[ -d $HOME/.local/bin ]] && export PATH=$HOME/.local/bin${PATH:+:}$PATH
[[ -d $HOME/bin ]] && export PATH=$HOME/bin${PATH:+:}$PATH
