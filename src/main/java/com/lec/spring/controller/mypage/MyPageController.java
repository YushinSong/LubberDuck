package com.lec.spring.controller.mypage;

import com.lec.spring.domain.User;
import com.lec.spring.domain.mypage.MypageValidator;
import com.lec.spring.domain.order.Order;
import com.lec.spring.domain.order.OrderItem;
import com.lec.spring.domain.review.Review;
import com.lec.spring.service.UserService;
import com.lec.spring.service.menu.MenuService;
import com.lec.spring.service.review.ReviewService;
import com.lec.spring.util.U;
import jakarta.validation.Valid;
import com.lec.spring.service.order.OrderService;
import com.lec.spring.service.order.OrderItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/mypage")
public class MyPageController {

    @Autowired
    private UserService userService;

    @Autowired
    private MenuService menuService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private OrderItemService orderItemService;

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private MypageValidator mypageValidator;

    @GetMapping("/info")
    public String info(Model model,
                       @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails == null) {
            // UserDetails가 null일 경우에 대한 처리
            // 로그인 페이지로 리디렉션할 수 있습니다.
            return "redirect:/user/login";
        }

        String username = userDetails.getUsername();
        User user = userService.findByUsername(username);
        if (user == null) {
            // 사용자가 null일 경우에 대한 처리
            // 적절한 예외 처리를 할 수 있습니다.
            return "redirect:/error";
        }

        model.addAttribute("user", user);
        model.addAttribute("menuList", menuService.sequenceList());
        return "mypage/info";
    }

    @GetMapping("/myPageUpdate")
    public String myPageUpdate(Model model,
                               @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails == null) {
            return "redirect:/user/login";
        }

        String username = userDetails.getUsername();
        User user = userService.findByUsername(username);
        if (user == null) {
            return "redirect:/error";
        }

        LocalDate birthDate = user.getBirth_date(); // 예: "1995-05-05"
        if(birthDate != null){
            model.addAttribute("year", birthDate.getYear());
            model.addAttribute("month", birthDate.getMonthValue());
            model.addAttribute("day", birthDate.getDayOfMonth());
        }

        model.addAttribute("user", user);
        return "mypage/myPageUpdate";

    }

    @PostMapping("/myPageUpdate")
    public String myPageUpdateOk(
            @RequestParam("year") int year
            ,@RequestParam("month") int month
            ,@RequestParam("day") int day
            , @Valid User user
            , BindingResult result
            , Model model
            , RedirectAttributes redirectAttrs
    ){
        if (result.hasErrors()){
            redirectAttrs.addFlashAttribute("nickname", user.getNickname());
            redirectAttrs.addFlashAttribute("email", user.getEmail());
            redirectAttrs.addFlashAttribute("year", year);
            redirectAttrs.addFlashAttribute("month", month);
            redirectAttrs.addFlashAttribute("day", day);

            List<FieldError> errList = result.getFieldErrors();
            for(FieldError err : errList){
                redirectAttrs.addFlashAttribute("error", err.getCode());
                break;
            }
            return "redirect:/mypage/myPageUpdate";
        }

        user.setBirth_date(LocalDate.of(year, month, day));

        int updateResult = userService.update(user);

        if (updateResult > 0) {
            model.addAttribute("success", true);
        } else {
            model.addAttribute("success", false);
        }

        return "mypage/myPageUpdate";
    }
    @RequestMapping("/info")
    public void info(){}
    @RequestMapping("/order")
    public void order(){}

    @GetMapping("/order")
    public String order(Model model, Integer page, @AuthenticationPrincipal UserDetails userDetails) {
        if (userDetails == null) {
            return "redirect:/user/login";
        }

        String username = userDetails.getUsername();
        User user = userService.findByUsername(username);

        if (user == null) {
            return "redirect:/error";
        }

        Long userId = user.getId();

        List<Order> orders = orderService.findByUser(userId);

        // 주문 항목들을 저장할 맵을 준비합니다.
        Map<Long, List<OrderItem>> orderItemsByOrderId = new HashMap<>();
        // 리뷰 항목들을 저장할 맵을 준비합니다.
        Map<Long, Review> reviewByOrderItemId = new HashMap<>();


        // 각 주문에 대해 주문 항목을 조회하고 맵에 저장합니다.
        for (Order order : orders) {
            List<OrderItem> items = orderItemService.findByOrder(order.getId());
            orderItemsByOrderId.put(order.getId(), items);

            // 각 아이템에 대해 리뷰 항목을 조회하고 맵에 저장합니다.
            for (OrderItem item : items) {
                Review review = reviewService.findByItemId(item.getId());
                reviewByOrderItemId.put(item.getId(), review);
            }
        }

        ZoneId zoneId = ZoneId.of("Asia/Seoul");
        orders.forEach(order -> {
            order.setRegdate(order.getRegdate().atZone(ZoneId.systemDefault()).toLocalDateTime());
        });

        // 모델에 주문 목록과 주문 항목 맵을 추가합니다.
        model.addAttribute("orders", orders);
        model.addAttribute("user", user);
        model.addAttribute("orderItemsByOrderId", orderItemsByOrderId);
        model.addAttribute("reviewByOrderItemId", reviewByOrderItemId);

        orderService.orderList(user.getId(), page, model);

        // mypage/order 뷰를 반환합니다.
        return "mypage/order";
    }

    @GetMapping("/review")
    public void review(@AuthenticationPrincipal UserDetails userDetails, Integer sort, Integer page, Model model) {
        String username = userDetails.getUsername();
        User user = userService.findByUsername(username);

        ZoneId zoneId = ZoneId.of("Asia/Seoul");
        List<Review> reviews = reviewService.findByUserId(user.getId());
        reviews.forEach(review -> {
            review.setRegdate(review.getRegdate().atZone(ZoneId.systemDefault()).toLocalDateTime());
        });

        model.addAttribute("user", user);
        model.addAttribute("reviews", reviews);

        reviewService.list(user.getId(), sort, page, model);

    }

    @GetMapping("review/detail/{id}")
    public String detail (Model model, @PathVariable("id") Long id){
        Review review = reviewService.selectById(id);
        model.addAttribute("review", review);
        return "mypage/review/detail";
    }

    @GetMapping("review/update/{id}")
    public String update(Model model, @PathVariable("id") Long id) {
        Review review = reviewService.selectById(id);
        model.addAttribute("review", review);
        return "mypage/review/update";
    }

    @GetMapping("/bookmark")
    public void bookmark(Model model){
        model.addAttribute("allList",menuService.list());
        model.addAttribute("menuList", menuService.sequenceList());
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.setValidator(new MypageValidator());
    }
}

