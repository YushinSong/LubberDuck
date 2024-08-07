
window.addEventListener('load', async () => {
    try {
        loadMenu();
        addEvent();
        avgRate(currentCocktail);

        if (logged_id !== -1) {
            await checkToRecent(currentCocktail);
            await loadRecent(logged_id);

            const recentSectionCon = document.getElementById("recentSection-con");
            const maxScrollTop = 2300; // 최대 스크롤 값

            window.addEventListener("scroll", function () {
                const scrollTop = window.scrollY || document.documentElement.scrollTop;

                let newTop = scrollTop;

                // If the new top position would exceed the max scroll top, limit it
                if (newTop + recentSectionCon.offsetHeight > maxScrollTop) {
                    newTop = maxScrollTop - recentSectionCon.offsetHeight;
                }

                recentSectionCon.style.top = newTop + "px";
            });
        }
    } catch (error) {
        console.error('Error during initialization:', error);
    }

    // changePage(1);
    renderPagination(reviewCount,1,1);
});


async function loadMenu() {
    $('#img').css({'background-image': `url('${menu.imgUrl}')`});
    document.querySelector(`#name`).textContent = `${menu.name}`;
    document.querySelector(`#info`).textContent = `${menu.info}`;
    document.querySelector(`#price`).textContent = `${menu.price} ￦`;
    // var cocktailName = `${menu.name}`;

    // 로그인 상태일때만 불러오기
    if (logged_id !== -1) {
        const isBookmarked = await checkBook(menu);

        // 즐겨찾기 존재여부에 따른 클래스 설정
        isBookmarked && switchToFullHeart(); // 참
        isBookmarked || switchToEmptyHeart(); // 거짓
    }
    if(menu.sequence == -1) {
        $('#toCart').text("판매종료");
        $('#toCart').addClass('endSell');
    }
}

function addEvent(){

    // Hide the comment-con when clicking outside of it
    $(document).click(function(event) {
        if (!$(event.target).closest('.comment-con').length && !$(event.target).closest('#heartImg').length) {
            $('.comment-con').css('display', 'none');
            $("#heart").css('display','block');
        }
    });

    // addToCart
    $('#toCart').click(function(e){
        // var cocktailName = $(this).parent().siblings("#name").text();
        addAnimationStart(e);
        addToCart(menu);
    });

   // swtichHeartIcon
    $('#heart').click(function(event) {
        if(event.target.className === "fullHeart"){
            event.stopPropagation();
            var cocktailName = $(this).closest('#cocktailsection').find('#name').text();
            deleteFromBook(menu);
            swal("DELETE",cocktailName+'가 즐겨찾기에서 삭제되었습니다.',"success");

            switchToEmptyHeart();
        } else if(event.target.className === "emptyHeart"){
            event.stopPropagation();
            openComment();
            $("#heart").css('display','none');
        }
    });

    // addToBook
    $('#commentCheck').click(function() {
        handleCommentSubmit();
    });

    // addToBook
    $('.comment-con').on('keydown', '.comment', function(e) {
        if (e.key === 'Enter') {
            e.preventDefault();  // Prevent the default action of the Enter key
            handleCommentSubmit();
        }
    });
}

function switchToFullHeart() {
    $('#container').find('#heart').removeClass('emptyHeart').removeClass('fullHeart').addClass('fullHeart');
}

function switchToEmptyHeart() {
    $('#container').find('#heart').removeClass('emptyHeart').removeClass('fullHeart').addClass('emptyHeart');
}

// 코멘트창 열기
function openComment() {
    $('.comment-con').css('display', 'block');
    $('.comment').css('height', '200px');
}

// 코멘트창 닫기
function closeComment() {
    $('#container').find(".comment").val('');
    $('.comment-con').css('display', 'none');
    $('.comment').css('height', '0px');
}

// 코멘트 내용 저장하기
function handleCommentSubmit() {
    var $cocktailSection = $('#commentCheck').closest('#cocktailsection');
    var cocktailName = $cocktailSection.find('#name').text();
    var commentValue = $cocktailSection.find('.comment').val();
    var errorMessage = $cocktailSection.find('.comment-error-message');

    // 글자 수 체크
    var maxLength = 30;
    if (commentValue.length > maxLength) {
        var currentLength = commentValue.length;
        var message = '코멘트는 30자까지 작성 가능합니다. (현재 ' + currentLength + '글자)';
        errorMessage.text(message);
        errorMessage.css('display', 'block');
        return; // 글자 수가 넘어가면 함수 종료
    } else {
        errorMessage.css('display', 'none');
    }

    addToBook(menu,commentValue);
    swal("SUCCESS", "즐겨찾기에 추가되었습니다", "success");
    $("#heart").css('display', 'block');

    switchToFullHeart();
    closeComment();
}

function formatDate(dateString) {
    const date = new Date(dateString);
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');
    return `${year}-${month}-${day} ${hours}:${minutes}`;
}

