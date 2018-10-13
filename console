#!/bin/bash

if [ -z "$1" ]; then
  export RUBY_ENV="development"
else
  export RUBY_ENV=$1
fi

irb -r ./application.rb