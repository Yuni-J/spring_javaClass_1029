console.log("boardModify in")

// function spreadFileList(bno){
//     getFileListFromServer(bno).then(result => {
//         //파일 뿌리기
//         const ul = document.getElementById('fileListArea');
//         if(result.fileList.length > 0){
//             ul.innerHTML = "";
//             for(let fvo of result.fileList){
//                 let li = `<li class="list-group-item">`;
//                 li += `<c:choose>`;
//                 li += `<c:when test="${fvo.fileType.equals('1')}">`;
//                 li += `<div><img alt="" src="/upload/${fvo.saveDir }/${fvo.uuid}_${fvo.fileName}"></div></c:when>`;
//                 li += `<c:otherwise>`;
//                 li += `<a href="/upload/${fvo.saveDir }/${fvo.uuid}_${fvo.fileName}" download="">`;
//                 li += `<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-file-earmark-arrow-down" viewBox="0 0 16 16">
// 							<path d="M8.5 6.5a.5.5 0 0 0-1 0v3.793L6.354 9.146a.5.5 0 1 0-.708.708l2 2a.5.5 0 0 0 .708 0l2-2a.5.5 0 0 0-.708-.708L8.5 10.293z"/>
// 							<path d="M14 14V4.5L9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2M9.5 3A1.5 1.5 0 0 0 11 4.5h2V14a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h5.5z"/>
// 						</svg> File Download </a> `;
//                 li += `</c:otherwise> </c:choose>`
//                 li += `<div class="fw-bold">${fvo.fileName }</div>`
//                 li += `<span class="badge text-bg-light rounded-pill">regDate ${fvo.regDate } / ${fvo.fileSize } Bytes</span>`;
//                 li += `<button type="button" data-uuid="${fvo.uuid }" id="fileDelBtn" class="btn btn-outline-danger btn-sm fdel">X</button>`;
//                 li += `</li>`
//                 ul.innerHTML += li;
//             } 
//         } else {
//             ul.innerHTML = `<li class="list-group-item">File List Empty</li>`;
//         }
//     })
// }

// 삭제
document.addEventListener('click', (e)=>{
    console.log(e.target);
    if(e.target.classList.contains('fdel')){
        // let li = e.target.closest('li');
        let uuid = e.target.dataset.uuid;
        removeFileToServer(uuid).then(result => {
            if(result == '1'){
                e.target.closest('li').remove();
                alert("파일 삭제 성공");
            } else{
                alert("파일 삭제 실패");
            }
            // // 파일 뿌리기
            // spreadFileList(bnoVal);
        })
    }
})

//delete 메서드
async function removeFileToServer(uuid) {
    try {
        const url = "/board/file/" + uuid;
        const config ={
            method: 'delete'
        }
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;        
    } catch (error) {
        console.log(error);
    }
}