#!/usr/bin/ruby -Ku
require 'pathname'
lib_dir = "bitclust/lib"
$LOAD_PATH.unshift(lib_dir)
require "bitclust"
require "bitclust/runner"
argv = [
        "server",
        "--bind-address=127.0.0.1",
        "--baseurl=",
        "--debug",
        "--auto",
        "--capi"
       ]
BitClust::Runner.new.run(argv)
