names=rfc1123_date
visibility=public
kind=defined

--- rfc1123_date(time) -> String

与えられた時刻を [[RFC:1123]] フォーマットに準拠した文字列に変換します。

@param time [[c:Time]] のインスタンスを指定します。

例：
        require "cgi"

        CGI.rfc1123_date(Time.now)
          # => Sat, 1 Jan 2000 00:00:00 GMT

