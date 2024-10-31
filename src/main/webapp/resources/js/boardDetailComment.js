console.log("boardDetailComment.js in");
console.log("vscode 연동");

document.getElementById('cmtAddBtn').addEventListener('click', ()=>{
    const cmtText = document.getElementById('cmtText');
    const cmtWriter = document.getElementById('cmtWriter');

    if(cmtText.value == null || cmtWriter.value == ''){
        alert('댓글을 입력해주세요.');
        cmtText.focus(); //value에는 포커스를 줄 수 없음
        return false;
    }
    let cmtData={
        bno: bnoVal,
        writer: cmtWriter.innerText,
        content: cmtText.value
    }
    console.log(cmtData);
    postCommentToServer(cmtData).then(result => {
        if(result == '1'){
            alert("댓글 등록 성공");
            cmtText.value = "";
            // 댓글 뿌리기
            spreadCommentList(bnoVal);
        }
    })
});

function spreadCommentList(bno, page=1){
    getCommentListFromServer(bno, page).then(result =>{
        console.log(result);
        // 댓글 뿌리기
        const ul = document.getElementById('cmtListArea');
        if(result.length > 0){
            ul.innerHTML="";  //반족 전에 기존 샘플 버리기
            for(let cvo of result){
                let li = `<li class="list-group-item" data-cno=${cvo.cno}>`;
                li += `<div class="list-group-item"> no.${cvo.cno}`;
                li += `<div class="fw-bold">${cvo.writer}</div>`;
                li += `${cvo.content}</div>`;
                li += `<span class="badge text-bg-light rounded-pill">regDate ${cvo.regDate }</span>`;
                //수정 삭제 버튼 추가
                li += `<button type="button" data-cno=${cvo.cno} class="btn btn-outline-warning btn-sm mod" data-bs-toggle="modal" data-bs-target="#myModal">%</button>`;
                li += `<button type="button" data-cno=${cvo.cno} class="btn btn-outline-danger btn-sm del">X</button>`;
                li += `</li>`;
                ul.innerHTML += li;
            }
        } else {
            ul.innerHTML = `<li class="list-group-item">Comment List Empty</li>`
        }
    })
}

// 수정 삭제
document.addEventListener('click', (e)=>{
    console.log(e.target);
    // 내가 클릭한 버튼의 객체를 모달창으로 전달
    if(e.target.classList.contains('mod')){
        // 내가 클릭한 버튼의 li가져오기 
        // closest : 가장 가까운(나를 포함한) 태그 (=> 부모태그)
        let li = e.target.closest('li');
        // nextSibling : 한 부모 안에서의 다음 형제 값 찾기
        let cmtText = li.querySelector('.fw-bold').nextSibling;
        console.log(cmtText);
        document.getElementById('cmtTextMod').value = cmtText.nodeValue;

        let cmtWriter = li.querySelector('.fw-bold').innerText;
        let cno = li.dataset.cno
        document.getElementById('cmtWriterMod').innerText = `No.${cno} | ${cmtWriter}`;
        // cmtModBtn => cno 값을 dataset으로 담기
        document.getElementById('cmtModBtn').setAttribute("data-cno", cno);
    }
    if(e.target.id == 'cmtModBtn'){
        let cmtData = {
            cno: e.target.dataset.cno,
            content: document.getElementById('cmtTextMod').value
        }
        console.log(cmtData);
        updateCommentToServer(cmtData).then(result =>{
            if(result == '1'){
                alert("댓글 수정 성공");
            } else{
                alert("댓글 수정 실패");
            }
            // 모달창 닫기 : btn-close 라는 객체를 클릭해라
            document.querySelector('.btn-close').click();
            // 댓글 뿌리기
            spreadCommentList(bnoVal);
        })
    }
    if(e.target.classList.contains('del')){
        let li = e.target.closest('li');
        let cno = li.dataset.cno;
        removeCommentToServer(cno).then(result => {
            if(result == '1'){
                alert("댓글 삭제 성공");
            } else{
                alert("댓글 삭제 실패");
            }
            // 댓글 뿌리기
            spreadCommentList(bnoVal);
        })
    
    }

    if(e.target.id == 'moreBtn'){
        let page = e.target.dateset.page;
    }
})

async function updateCommentToServer(cmtData) {
    try {
        const url = "/comment/modify";
        const config = {
            method: 'put',
            headers: {
                'Content-Type' : 'application/json; charset=utf-8'
            },
            body: JSON.stringify(cmtData)
        };
        const resp = await fetch(url, config);
        const result = await resp.text();  // isOk
        return result;
    } catch (error) {
        console.log(error);
    }
}

// delete 메서드
async function removeCommentToServer(cno) {
    try {
        const url = "/comment/" + cno;  //그냥 보내는 것은 get / get은 생략가능
        const config = {
            method: 'delete'
        }
        const resp = await fetch(url, config);
        //const resp = await fetch("/comment/" + cno, {method: 'delete'});  //직접 구성 가능
        const result = await resp.text();  // isOk
        return result;
    } catch (error) {
        console.log(error);
    }
    
}

async function getCommentListFromServer(bno, page) {
    try {
        const resp = await fetch("/comment/"+bno+"/"+page);
        const result = await resp.json();
        return result;        
    } catch (error) {
        console.log(error);
    }
}


async function postCommentToServer(cmtData) {
    try {
        const url = "/comment/post";
        const config = {
            method: "post",
            headers:{
                'Content-type':'application/json; charset=utf-8'
            },
            body: JSON.stringify(cmtData)
        };
        const resp = await fetch(url, config);
        console.log(resp);
        const result = await resp.text();  // isOk
        return result;
    } catch (error) {
        console.log(error);
    }
    
};
 