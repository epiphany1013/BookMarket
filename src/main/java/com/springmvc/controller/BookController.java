package com.springmvc.controller;

import com.springmvc.exception.CategoryException;
import com.springmvc.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import com.springmvc.domain.Book;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import java.io.*;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Controller
@RequestMapping("/books")
public class BookController {
    @Autowired
    private BookService bookService;
    @Autowired
    ServletContext servletContext;


    @GetMapping
    public String requestBookList(Model model) {
        List<Book> list = bookService.getAllBookList();
        model.addAttribute("bookList", list);
        return "books";
    }

    @GetMapping("/all")
    public ModelAndView requestAllBooks() {
        ModelAndView modelAndView = new ModelAndView();
        List<Book> list = bookService.getAllBookList();
        modelAndView.addObject("bookList", list);
        modelAndView.setViewName("books");
        return modelAndView;
    }

    @GetMapping("/{category}")
    public String requestBooksByCategory(@PathVariable("category") String bookCategory, Model model) {
        List<Book> booksByCategory = bookService.getBookListByCategory(bookCategory);
        if (booksByCategory == null || booksByCategory.isEmpty()) {
            throw new CategoryException();
        }
        model.addAttribute("bookList", booksByCategory);
        return "books";
    }

    @GetMapping("/filter/{bookFilter}")
    public String requestBooksByFilter(
            @MatrixVariable(pathVar = "bookFilter") Map<String, List<String>> bookFilter,
            Model model) {
        Set<Book> booksByFilter = bookService.getBookListByFilter(bookFilter);
        model.addAttribute("bookList", booksByFilter);
        return "books";
    }

    @GetMapping("/book")
    public String requestBookById(@RequestParam("id") String bookId, Model model) {
        Book bookById = bookService.getBookById(bookId);
        model.addAttribute("book", bookById);
        return "book";
    }

    @GetMapping("/add")
    public String requestAddBookForm(@ModelAttribute("NewBook") Book book) {
        return "addBook";
    }

    @PostMapping("/add")
    public String submitAddNewBook(@ModelAttribute("NewBook") Book book) {
        MultipartFile bookImage = book.getBookImage();

        String saveName = bookImage.getOriginalFilename();
//        File saveFile = new File("/Users/gh/Documents/code/java/BookMarket/src/main/webapp/resources/images", saveName);
//        File saveFile = new File("/resources/images", saveName); // java파일에서는 경로를 절대경로로 적어주어야하고, jsp에서는 상대경로로 적어주어야 한다.
        String rootPath = servletContext.getRealPath("/");
        File saveFile = new File(rootPath + "resources/images", saveName); //ServletContext를 이용하여 웹 애플리케이션의 루트 경로를 얻을 수 있습니다. 이 경로에 /resources/images를 추가하여 이미지 저장 경로를 구성하는 방법 알아냄

        if (bookImage != null && !bookImage.isEmpty()) {
            try (InputStream inputStream = bookImage.getInputStream();
                 OutputStream outputStream = new FileOutputStream(saveFile)) {

                byte[] buffer = new byte[1024];
                int bytesRead;

                while ((bytesRead = inputStream.read(buffer)) != -1) {
                    outputStream.write(buffer, 0, bytesRead);
                }

            } catch (IOException e) {
                throw new RuntimeException("도서 이미지 업로드가 실패하였습니다", e);
            }
        }
//        if (bookImage != null && !bookImage.isEmpty()) {
//            try {
//                bookImage.transferTo(saveFile);
//            } catch (Exception e) {
//                throw new RuntimeException("도서 이미지 업로드가 실패하였습니다", e);
//            }
//        }
        bookService.setNewBook(book);
        return "redirect:/books";
    }

    @ModelAttribute
    public void addAttributes(Model model) {
        model.addAttribute("addTitle", "신규 도서 등록");
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.setAllowedFields("bookId", "name", "unitPrice", "author", "description", "publisher", "category", "unitsInstock", "totalPages", "releaseDate", "condition", "bookImage");
    }
}
