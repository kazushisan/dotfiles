# dotfiles

```

           __     __  ____ __         
       ___/ /__  / /_/ _(_) /__ ___   
      / _  / _ \\/ __/ _/ / / -_|_-<  
      \\_,_/\\___/\\__/_//_/_/\\__/___/   

      github.com/kazushisan/dotfiles
			
```
## Usage

```zsh
make help ## show list of commands
make init ## init environment
```

## some lines to add to `~/.zshenv` (optional)


```zsh
# java / android studio
export PATH=$PATH:/Applications/"Android Studio.app"/Contents/jre/jdk/Contents/Home/bin
export JAVA_HOME=/Applications/"Android Studio.app"/Contents/jre/jdk/Contents/Home

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# rbenv
eval "$(rbenv init -)"
```
