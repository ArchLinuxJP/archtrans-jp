function doPost(e) {
  var contents = e.postData.contents;
  var d = JSON.parse(contents);
  var spanish = LanguageApp.translate(d.txt,
                                      'en', 'ja', {contentType: 'html'});
  Logger.log(spanish);
  return ContentService.createTextOutput(spanish);
}

function doGet(e) {
  return ContentService.createTextOutput("doGet!!");
}
