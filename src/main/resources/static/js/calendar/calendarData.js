/********************************************
                캘린더
 ********************************************/
// 특정 날짜의 데이터가 존재하는지 확인
async function checkDate(dateId) {
    const response = await $.ajax({
        url: "/calendar/detail/" + dateId,
        type: "GET",
        cache: false
    });

    // 응답 객체에서 id 필드가 존재하는지를 확인하여 데이터의 존재 여부를 판단
    if (response.id) {
        const id = response.id;
        const memo = response.memo;
        const menu_id = response.menu_id;
        const comment = response.comment;

        return {
            exists: true,
            id: id,
            menu_id: menu_id,
            comment: comment,
            memo: memo
        };
    } else {
        return false;
    }
}
// 모든 일정 불러오기
function loadCalendars(){
    $.ajax({
        type: "GET",
        url: `/calendar/list`,
        cache: false,
        success: function (data, status) {
            if (status === "success") {
                if (data.status !== "OK") {
                    return;
                }
                buildCalendar(data.data);
            }
        },
    });
}

// 특정 날짜 데이터 불러오기
async function loadData(dateId){
    $.ajax({
        url: "/calendar/detail/" + dateId,
        type: "GET",
        cache: false,
        success: function (data, status) {
            console.log("data:", data, "/dataId:", dateId);
            if (status === "success") {
                clearTodayMenuMemo();
                buildTodayMenu(data);
                buildMemo(data);
            }

            if (data.id) {
                addEvent(dateId);
            } else {
                removeEvent(dateId);
            }
        },
        error: function (xhr, status, error) {
            swal("Error","캘린더를 불러오지 못했습니다. 서버에서 오류가 발생했습니다.","error");
        }
    });
}

/********************************************
                오늘의 메뉴
 ********************************************/

// 오늘의 메뉴 추가
async function addCalendarByMenu(menuId, comment) {
    const {dateInt, selectedDate} = await checkAndConvertDate();
    const checkDateResult = await checkDate(dateInt);

    const data = {
        "menu_id": menuId,
        "comment": comment,
        "date": selectedDate,
        "memo": checkDateResult.exists ? checkDateResult.memo : null
    };

    const url = checkDateResult.exists ? `/calendar/update/${dateInt}` : "/calendar/addByMenu";

    $.ajax({
        url: url,
        type: "POST",
        data: data,
        cache: false,
        success: function(data, status) {
            if (status === "success" && data.status === "OK") {
                swal("SUCCESS","오늘의 메뉴가 추가되었습니다.","success");
                loadData(dateInt);
                $("#myForm2").hide();
                $(".popup-overlay").remove();
            }
        }
    });
}

// 오늘의 메뉴 수정
async function updateCalendarByMenu(menuId, comment) {
    const {dateInt, selectedDate} = await checkAndConvertDate();
    const checkDateResult = await checkDate(dateInt);

    const data = {
        "menu_id": menuId,
        "comment": comment,
        "date": selectedDate,
        "memo": checkDateResult.exists ? checkDateResult.memo : null
    };

    $.ajax({
        url: `/calendar/update/${dateInt}`,
        type: "POST",
        data: data,
        cache: false,
        success: function(data, status) {
            if (status === "success" && data.status === "OK") {
                swal("SUCCESS","오늘의 메뉴가 수정되었습니다.","success");
                loadData(dateInt);
                $("#myForm2").hide();
                $(".popup-overlay").remove();
            }
        }
    });
}

// 오늘의 메뉴 삭제
async function deleteCalendarByMenu(calendarId, menuId, comment) {
    const {dateInt, selectedDate} = await checkAndConvertDate();
    const checkDateResult = await checkDate(dateInt);

    const data = {
        "id": calendarId,
        "menu_id": menuId,
        "comment": comment,
        "date": selectedDate,
        "memo": checkDateResult.exists ? checkDateResult.memo : null
    };

    let url;
    if (checkDateResult.exists && checkDateResult.memo !== null) {
        url = `/calendar/updateToDeleteMenu/${calendarId}`;
    } else {
        url = `/calendar/deleteById/${calendarId}`;
    }

    $.ajax({
        url: url,
        type: "POST",
        data: data,
        cache: false,
        success: function(data, status) {
            if (status === "success" && data.status === "OK") {
                swal("SUCCESS","오늘의 메뉴가 삭제되었습니다.","success");
                loadData(dateInt);
                $('.today-menu-container').empty();
                $('#select-menu-text').empty();
            }
        }
    });
}


/********************************************
                    메모
 ********************************************/

// 메모 추가
async function addCalendarByMemo(memo) {
    const {dateInt, selectedDate} = await checkAndConvertDate();
    const checkDateResult = await checkDate(dateInt);

    const data = {
        "menu_id": checkDateResult.exists ? checkDateResult.menu_id : null,
        "comment": checkDateResult.exists ? checkDateResult.comment : null,
        "date": selectedDate,
        "memo": memo
    };

    const url = checkDateResult.exists ? `/calendar/update/${dateInt}` : "/calendar/addByMemo";

    $.ajax({
        url: url,
        type: "POST",
        data: data,
        cache: false,
        success: function(data, status) {
            if (status === "success" && data.status === "OK") {
                swal("SUCCESS","메모가 추가되었습니다.","success");
                loadData(dateInt);
                $(".memo-delete, .memo-edit").show();
            }
        }
    });
}

// 메모 수정
async function updateCalendarByMemo(memo) {
    const { dateInt, selectedDate } = await checkAndConvertDate();
    const checkDateResult = await checkDate(dateInt);

    const data = {
        "menu_id": checkDateResult.exists ? checkDateResult.menu_id : null,
        "comment": checkDateResult.exists ? checkDateResult.comment : null,
        "date": selectedDate,
        "memo": memo
    };


    $.ajax({
        url: `/calendar/update/${dateInt}`,
        type: "POST",
        data: data,
        cache: false,
        success: function(data, status) {
            if (status === "success" && data.status === "OK") {
                $("#new-memo").val("").hide();
                swal("SUCCESS","메모가 수정되었습니다.","success");
                loadData(dateInt);
                $(".memo-delete, .memo-edit").show();
            }
        }
    });
}

// 메모 삭제
async function deleteCalendarByMemo(calendarId, memo) {
    const {dateInt, selectedDate} = await checkAndConvertDate();
    const checkDateResult = await checkDate(dateInt);

    const data = {
        "menu_id": checkDateResult.exists ? checkDateResult.menu_id : null,
        "comment": checkDateResult.exists ? checkDateResult.comment : null,
        "date": selectedDate,
        "memo": memo
    };

    let url;
    if (checkDateResult.exists && checkDateResult.menu_id !== null) {
        url = `/calendar/updateToDeleteMemo/${calendarId}`;
    } else {
        url = `/calendar/deleteById/${calendarId}`;
    }

    $.ajax({
        url: url,
        type: "POST",
        data: data,
        cache: false,
        success: function(data, status) {
            if (status === "success" && data.status === "OK") {
                swal("SUCCESS","메모가 삭제되었습니다.","success");
                loadData(dateInt);
            }
        }
    });
}