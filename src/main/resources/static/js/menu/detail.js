
window.addEventListener('load', async () => {
    try {
        loadMenu();
        addEvent();

        if (logged_id !== -1) {
            await checkToRecent(currentCocktail);
            await loadRecent(logged_id);
        }
    } catch (error) {
        console.error('Error during initialization:', error);
    }
});
window.addEventListener('popstate', function (event) {
    // This code runs when the back button is clicked
    alert('popstate event triggered');
    location.reload(); // Refresh the page
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
    $('#toCart').click(function(){
        var cocktailName = $(this).parent().siblings("#name").text();
        addToCart(menuList.find(menu => menu.name === cocktailName));
    });

   // swtichHeartIcon
    $('#heart').click(function(event) {
        if(event.target.className === "fullHeart"){
            event.stopPropagation();
            var cocktailName = $(this).closest('#cocktailsection').find('#name').text();
            deleteFromBook(menuList.find(menu => menu.name === cocktailName));
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
        var cocktailName = $(this).closest('#cocktailsection').find('#name').text();
        var commentValue = $(this).closest('#cocktailsection').find('.comment').val();
        var errorMessage = $(this).closest('#cocktailsection').find('.comment-error-message');

        // 글자 수 체크
        var maxLength = 30;
        if (commentValue.length > maxLength) {
            var currentLength = commentValue.length;
            var message = '코멘트는 30자까지 작성 가능합니다. (현재 ' + currentLength + '글자)';
            errorMessage.text(message);
            errorMessage.css('display','block');
            return; // 글자 수가 넘어가면 함수 종료
        } else {
            errorMessage.css('display', 'none');
        }

        addToBook(menuList.find(menu => menu.name === cocktailName), commentValue);
        swal("SUCCESS", "즐겨찾기에 추가되었습니다", "success");
        $("#heart").css('display', 'block');

        switchToFullHeart();
        closeComment();
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


//다혜
// document.addEventListener('DOMContentLoaded', function () {
//     const reviewTexts = document.querySelectorAll('.review-text');
//
//     reviewTexts.forEach(text => {
//         text.addEventListener('click', () => {
//             const reviewContent = text.parentElement;
//
//             // 다른 review-text들의 확장 상태를 초기화하고 추가 버튼을 숨깁니다.
//             reviewTexts.forEach(otherText => {
//                 if (otherText !== text) {
//                     otherText.classList.remove('expanded');
//                 }
//             });
//
//             // 현재 클릭한 review-text와 해당하는 추가 버튼의 상태를 toggle합니다.
//             text.classList.toggle('expanded');
//             extraButtons.classList.toggle('show');
//         });
//     });
//
// });


function formatDate(dateString) {
    const date = new Date(dateString);
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');
    return `${year}-${month}-${day} ${hours}:${minutes}`;
}

$(document).ready(function () {
    // 예제 데이터로 임시 리뷰 목록 설정
    console.log(reviews);
    reviewsData = reviews;

    // 최신순으로 초기에 정렬하여 렌더링
    renderReviews(sortReviews(reviewsData, '최신순'));

    // 정렬 함수: 최신순 또는 별점순으로 리뷰를 정렬합니다.
    function sortReviews(reviews, sortType) {
        if (sortType === '최신순') {
            return reviews.slice().sort((a, b) => new Date(b.regdate) - new Date(a.regdate));
        } else if (sortType === '별점순') {
            return reviews.slice().sort((a, b) => b.rate - a.rate);
        }
        return reviews;
    }

    // 리뷰 목록을 HTML에 렌더링합니다.
    function renderReviews(reviews) {
        var reviewsContainer = document.querySelector('.reviews-container');
        reviewsContainer.innerHTML = ''; // 기존 리뷰를 비웁니다.

        reviews.forEach(function (review) {
            var reviewElement = document.createElement('div');
            reviewElement.classList.add('review');

            // 리뷰 내용 구성
            reviewElement.innerHTML = `
                <div class="review-content">
                    <div class="review-header">
                        <div class="review-title">
                            <span class="star-img">${generateStars(review.rate)}</span>
                            <span class="star_score">${review.rate}</span>
                            <h6 id="review_name">${review.user.nickname}</h6>
                        </div>
                        <span class="review-regdate">${formatDate(review.regdate)}</span>
                    </div>
                    <div class="review-text">${review.content}</div>
                    <hr class="review_hr">
                </div>
            `;

            reviewsContainer.appendChild(reviewElement);
        });
    }

    // 별점 이미지를 생성합니다.
    function generateStars(score) {
        var starImgFull = '<img src="/img/review/yellow_star.png" class="star-img">';
        var starImgEmpty = '<img src="/img/review/grey_star.png" class="star-img">';
        var fullStars = starImgFull.repeat(score);
        var emptyStars = starImgEmpty.repeat(5 - score);
        return fullStars + emptyStars;
    }

    // 라디오 버튼 변경 시 리뷰를 다시 정렬하여 렌더링
    $('input[name="sort"]').change(function () {
        var sortType = $(this).val();
        var sortedReviews = sortReviews(reviewsData, sortType);
        renderReviews(sortedReviews);
    });
});