# ~/.bash_profile: executed by bash(2) for login shells
#
# Created by Matthew D. Rankin
# Copyright (c) 2010 Matthew D. Rankin. All rights reserved.

################################
##### OS Agnostic Settings #####
################################

# Determine the operating system (used in bashrc)
os_name=`uname -s`

# Include the non-login shell settings if running bash
if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
      . "$HOME/.bashrc"
  fi
fi

# Add the user's bin to the PATH
if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:${PATH}"
fi

# Set the editor to vim regardless of OS
export EDITOR='vim'

##################################
##### OS X Specific Settings #####
##################################

# Note: OS X Terminal.app runs a login shell by default
# (i.e., shells open with the default login shell (/usr/bin/login)

if [ ${os_name} == 'Darwin' ]; then
    ## Python stuff starts here
    PY_INSTALL_SCRIPTS_DIR="$(brew --prefix)/bin"

    # If pip is installed set the download cache
    if [ -x ${PY_INSTALL_SCRIPTS_DIR}/pip ]; then
      export PIP_REQUIRE_VIRTUALENV=false
    else
      echo "WARNING: Can't find pip"
    fi

    # If virtualenv is installed, set some related config info
    if [ -x ${PY_INSTALL_SCRIPTS_DIR}/virtualenv ]; then
      export WORKON_HOME=$HOME/.virtualenvs
      if [ -x ${PY_INSTALL_SCRIPTS_DIR}/pip ]; then
        export PIP_VIRTUALENV_BASE=$WORKON_HOME
      fi
    else
      echo "WARNING: Can't find virtualenv"
    fi

    # Enable virtualenvwrapper
    if [ -x ${PY_INSTALL_SCRIPTS_DIR}/virtualenvwrapper.sh ]; then
        . ${PY_INSTALL_SCRIPTS_DIR}/virtualenvwrapper.sh
    else
      echo "WARNING: Can't find virtualenvwrapper"
    fi


fi

###################################
##### Linux Specific Settings #####
###################################
if [ ${os_name} == 'Linux' ]; then
    # Enable virtualenvwrapper
    if [ -x /usr/local/bin/virtualenvwrapper.sh ]; then
        if [ ! -d $HOME/.virtualenvs ]; then
            mkdir $HOME/.virtualenvs
        fi
        export WORKON_HOME=$HOME/.virtualenvs
        export PIP_VIRTUALENV_BASE=$WORKON_HOME
        # export PIP_REQUIRE_VIRTUALENV=true
        . /usr/local/bin/virtualenvwrapper.sh
    fi
fi
