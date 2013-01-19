names=escapeHTML
visibility=public
kind=defined

--- escapeHTML(string) -> String

与えられた文字列中の &"<> を実体参照に置換した文字列を新しく作成し返します。

@param string 文字列を指定します。

        require "cgi"

        p CGI.escapeHTML("3 > 1")   #=> "3 &gt; 1"

        print('<script type="text/javascript">alert("警告")</script>')

        p CGI.escapeHTML('<script type="text/javascript">alert("警告")</script>')
        #=> "&lt;script type=&quot;text/javascript&quot;&gt;alert(&quot;警告&quot;)&lt;/script&gt;"

