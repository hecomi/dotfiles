names=escapeElement
visibility=public
kind=defined

--- escapeElement(string, *elements) -> String
第二引数以降に指定したエレメントのタグだけを実体参照に置換します。

@param string 文字列を指定します。

@param elements HTML タグの名前を一つ以上指定します。文字列の配列で指定することも出来ます。

例：
        require "cgi"

        p CGI.escapeElement('<BR><A HREF="url"></A>', "A", "IMG")
             # => "<BR>&lt;A HREF="url"&gt;&lt;/A&gt"

        p CGI.escapeElement('<BR><A HREF="url"></A>', ["A", "IMG"])
             # => "<BR>&lt;A HREF="url"&gt;&lt;/A&gt"

