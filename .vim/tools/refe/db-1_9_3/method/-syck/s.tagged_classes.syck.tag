names=tagged_classes
visibility=public
kind=added

--- tagged_classes -> {String => Class}

タグ URI と、それが対応するクラスの一覧を返します。

例:

 require "pp"
 require "syck"
 require "yaml"
 pp YAML.tagged_classes
 # => {"tag:ruby.yaml.org,2002:struct"=>Struct,
 "tag:yaml.org,2002:set"=>YAML::Set,
 "tag:ruby.yaml.org,2002:sym"=>Symbol,
 "tag:yaml.org,2002:omap"=>YAML::Omap,
 ...}
