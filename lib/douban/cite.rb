require 'douban/cite/version'

require 'library_stdnums'
require 'json'
require 'rest_client'


module Douban
  module Cite
    Douban_API_base = 'https://api.douban.com'
    Douban_Book_info = Douban_API_base + '/v2/book/'

    module_function

    # @param [String] id isbn or douban subject id
    # @return [Hash] book info if success
    # @return [String] response http code if something is wrong
    def get_book_info(id)
      # Currently douban subject id's length is 7.
      if StdNum::ISBN.valid?(id)
        id = 'isbn/' + id
      end
      res = RestClient.get(Douban_Book_info + id)
      if res.code == 200
        JSON.parse(res.body)
      else
        res.code
      end
    end

    # Format:
    # author. YYYY-MM. title[type]. other_author. location: publisher. ISBN isbn-number
    # This format is based on:
    # - [GB 7714-2005《文后参考文献著录规则》](http://gradschool.ustc.edu.cn/ylb/material/xw/wdxz/19.pdf)
    # - [维基百科:列明来源](http://zh.wikipedia.org/wiki/Wikipedia:%E5%88%97%E6%98%8E%E6%9D%A5%E6%BA%90)
    # - [Harvard referencing](http://en.wikipedia.org/wiki/Parenthetical_referencing)
    #
    # @param [Hash]
    # @return [String]
    def convert_to_ref(book_info, book_type='M')
      author = book_info['author'].join(', ')
      year_month = book_info['pubdate']
      title = book_info['title']
      other_author = book_info['translator'].join(', ')
      publisher = book_info['publisher']
      # This is a silly guess.
      # TODO email douban to complain about this.
      location = publisher[0..1]
      isbn = book_info['isbn13']
      # `other_author` is handled specially, because often it is not needed.
      "#{author}. #{year_month}. #{title}[#{book_type}]. #{other_author == '' ? '' : other_author + '. ' }#{location}: #{publisher}. ISBN #{isbn}"
    end
  end
end
