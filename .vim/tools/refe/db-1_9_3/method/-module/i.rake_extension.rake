names=rake_extension
visibility=public 
kind=added

--- rake_extension(method){ ... } -> ()

与えられたブロック内で既に存在するメソッドを再定義しようとした場合に
警告を表示します。この場合、ブロックは評価されません。

@param method ブロック内で再定義する予定のメソッド名を指定します。

例:
   class String
     rake_extension("xyz") do
       def xyz
         ...
       end
     end
   end


