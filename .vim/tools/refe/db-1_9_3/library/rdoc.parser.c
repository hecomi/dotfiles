requires=rdoc.parser,rdoc,rdoc.code_objects,rdoc.code_object,rdoc.context,rdoc.top_level,rdoc.class_module,rdoc.normal_class,rdoc.normal_module,rdoc.anon_class,rdoc.single_class,rdoc.any_method,rdoc.alias,rdoc.ghost_method,rdoc.meta_method,rdoc.attr,rdoc.constant,rdoc.require,rdoc.include,rdoc.stats,rdoc.parser.simple,rdoc.parser.ruby,e2mmap,irb.slex,irb.notifier,irb.output=2dmethod,rdoc.token_stream,rdoc.known_classes
classes=RDoc=Parser=C
methods=
sublibraries=
is_sublibrary=true
category=

C 言語で記述されたソースコードから組み込みクラス/モジュールのドキュメン
トを解析するためのサブライブラリです。

C 言語で記述された拡張ライブラリなどを解析するのに使用します。
[[f:rb_define_class]] や [[f:rb_define_method]] などで定義されたものに
対応する C 言語の関数のコメントを解析します。

例: Array#flatten の場合。rb_ary_flatten のコメントが解析されます。

  /*
   * Returns a new array that is a one-dimensional flattening of this
   * array (recursively). That is, for every element that is an array,
   * extract its elements into the new array.
   *
   *    s = [ 1, 2, 3 ]           #=> [1, 2, 3]
   *    t = [ 4, 5, 6, [7, 8] ]   #=> [4, 5, 6, [7, 8]]
   *    a = [ s, t, 9, 10 ]       #=> [[1, 2, 3], [4, 5, 6, [7, 8]], 9, 10]
   *    a.flatten                 #=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
   */
   static VALUE
   rb_ary_flatten(ary)
       VALUE ary;
   {
       ary = rb_obj_dup(ary);
       rb_ary_flatten_bang(ary);
       return ary;
   }
   
   ...
   
   void
   Init_Array()
   {
     ...
     rb_define_method(rb_cArray, "flatten", rb_ary_flatten, 0);

上記の例の場合、rb_ary_flatten 関数と Init_Array 関数は同じファイルに記
述されている必要があります。

また、Ruby のソースコードとは別にコメントには特別な命令を指定する事がで
きます。

: Document-class: name

  記述する内容を name で指定した Ruby のクラスのものに指定します。同じ
  .c ファイルに複数のクラス定義がある場合などのように、Init_xxx 関数の
  xxx の部分がクラス名と同一ではない場合に使用します。

: Document-method: name

  記述する内容を name で指定した Ruby のメソッドのものに指定します。
  RDoc が対応するメソッドを見つけられなかった場合に使用します。

: call-seq:

  指定した次の行から次の空行までをメソッド呼び出し列と解釈します。

また、RDoc は rb_define_method などの定義と C 言語の関数の実装が同じファ
イルにある事を前提としています。そうでない場合は以下のような指定を行います。

  rb_define_method(....);  // in ファイル名

例:

  /*
   * Document-class:  MyClass
   *
   * Encapsulate the writing and reading of the configuration
   * file. ...
   */
  
  /*
   * Document-method: read_value
   *
   * call-seq:
   *   cfg.read_value(key)            -> value
   *   cfg.read_value(key} { |key| }  -> value
   *
   * Return the value corresponding to +key+ from the configuration.
   * In the second form, if the key isn't found, invoke the
   * block and return its value.
   */
