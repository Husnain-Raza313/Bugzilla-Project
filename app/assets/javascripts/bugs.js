function changeStatusforBug(){
  var element = document.getElementById("feature_status");
  element.classList.add("status_class");
  var element = document.getElementById("bug_status");
  element.classList.remove("status_class");

}

 function changeStatusforFeature(){
  var element = document.getElementById("bug_status");
  element.classList.add("status_class");
  var element = document.getElementById("feature_status");
  element.classList.remove("status_class");





 }

function checkStatus(){
  link = document.querySelector('#feature_id');
    let check = link.getAttribute('checked');
//  var check= document.getElementById("bug_id").getAttribute(checked)
  console.log(check)
  check== null ? changeStatusforBug() : changeStatusforFeature()

}
