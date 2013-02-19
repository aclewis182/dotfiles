# ~/.bash_profile: executed by bash(1) for login shells
#
# Created by Matthew D. Rankin
# Copyright (c) 2010 Matthew D. Rankin. All rights reserved.

################################
##### OS Agnostic Settings #####
################################

# Determine the operating system (used in bashrc)
os_name=`uname -s`

# Include the non-login shell settings
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Add the user's bin to the PATH
if [ -d ~/bin ]; then
    PATH=~/bin:"${PATH}"
fi

# Add /usr/local/bin and ./sbin to $PATH since OS X 10.6 adds
# /usr/local/bin after /usr/bin
export PATH=/usr/local/bin:/usr/local/sbin:"${PATH}"

# Set the editor to vim regardless of OS
export EDITOR='vim'

##################################
##### OS X Specific Settings #####
##################################

# Note: OS X Terminal.app runs a login shell by default
# (i.e., shells open with the default login shell (/usr/bin/login)

if [ ${os_name} == 'Darwin' ]; then
    ## Python stuff starts here
    # Note: 29-Aug-12. I'm no longer installing mupltiple versions
    # of Python using the python.org DMGs. Instead, I installed
    # python 2.7.3 using homebrew.
    PY_INSTALL_SCRIPTS_DIR="/usr/local/share/python"
    export PATH="${PY_INSTALL_SCRIPTS_DIR}":"${PATH}"
    export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

    # Check for virtualenv in the default Python
    if [ -x ${PY_INSTALL_SCRIPTS_DIR}/virtualenv ]; then
        export VIRTUALENV_USE_DISTRIBUTE=true
        export WORKON_HOME=$HOME/.virtualenvs
    fi
    
    # Check for pip
    if [ -x ${PY_INSTALL_SCRIPTS_DIR}/pip ]; then
        export PIP_VIRTUALENV_BASE=$WORKON_HOME
        export PIP_REQUIRE_VIRTUALENV=false
        export PIP_DOWNLOAD_CACHE=$HOME/.pip_download_cache
    fi
    
    # Enable virtualenvwrapper
    if [ -x ${PY_INSTALL_SCRIPTS_DIR}/virtualenvwrapper.sh ]; then
        . ${PY_INSTALL_SCRIPTS_DIR}/virtualenvwrapper.sh
    fi
    
    ## Ruby stuff starts here
    # If RVM is installed, load it into a shell session
    if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
        . "$HOME/.rvm/scripts/rvm"
        # Setup RVM BASH completion
        if [[ -r $rvm_path/scripts/completion ]]; then
            . $rvm_path/scripts/completion
        fi
    fi

    ## Node.js stuff starts here
    if [ -x /usr/local/bin/node ]; then
      export NODE_PATH=/usr/local/lib/node_modules
      export PATH=/usr/local/share/npm/bin:"${PATH}"
    fi
fi

###################################
##### Linux Specific Settings #####
###################################
if [ ${os_name} == 'Linux' ]; then
    # Enable virtualenvwrapper
    if [ -x /usr/local/bin/virtualenvwrapper_bashrc ]; then
        if [ ! -d $HOME/.virtualenvs ]; then
            mkdir $HOME/.virtualenvs
        fi
        export WORKON_HOME=$HOME/.virtualenvs
        export PIP_VIRTUALENV_BASE=$WORKON_HOME
        # export PIP_REQUIRE_VIRTUALENV=true
        . /usr/local/bin/virtualenvwrapper_bashrc
    fi
fi

