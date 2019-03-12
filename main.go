package main

import (
	"encoding/json"
	"fmt"
	"github.com/weakish/goaround"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"strings"
)

const DoubanAPIBase = "https://api.douban.com/v2"
const DoubanBook = DoubanAPIBase + "/book/isbn/"

const exUnavailable = 69

var logger = log.New(os.Stderr, "", 0)

type ISBN string
type Book map[string]interface{}
type Citation string

func main() {
	isbn := handleArguments()

	res, err := http.Get(DoubanBook + string(isbn))
	goaround.FatalIf(err)
	gentleClose := func() {
		err := res.Body.Close()
		goaround.FatalIf(err)
	}
	defer gentleClose()

	status := res.StatusCode
	if status == 200 {
		body, err := ioutil.ReadAll(res.Body)
		goaround.FatalIf(err)
		citation := parseBook(body)
		fmt.Println(citation)
	} else {
		logger.Printf("HTTP ERROR: %d\n", status)
		os.Exit(exUnavailable)
	}
}

func handleArguments() ISBN {
	args := os.Args
	var isbn ISBN
	switch len(args) {
	case 2:
		isbn = ISBN(args[1])
		return isbn
	default:
		panic("Usage: douban-cite ISBN")
	}
}

func parseBook(b []byte) Citation {
	var book Book
	err := json.Unmarshal(b, &book)
	if err == nil {

		yearMonth := book["pubdate"].(string) + ". "
		title := book["title"].(string) + "[M]. "
		publisher := book["publisher"].(string) + ". "
		isbn := "ISBN " + book["isbn13"].(string)

		authors := book["author"].([]interface{})
		translators := book["translator"].([]interface{})
		author := parseArray(authors)
		otherAuthor := parseArray(translators)

		return Citation(author + yearMonth + title + otherAuthor + publisher + isbn)
	} else {
		panic("PARSE ERROR:\n\n" + string(b) + "\n")
	}
}

func parseArray(arr []interface{}) string {
	length := len(arr)
	switch length {
	case 0:
		return ""
	case 1:
		return arr[0].(string) + ". "
	default:
		results := make([]string, len(arr))
		for i, item := range arr {
			results[i] = item.(string)
		}
		return strings.Join(results, ", ") + ". "
	}
}