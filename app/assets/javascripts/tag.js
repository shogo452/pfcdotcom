// ページ更新でtag-it発火
$(document).ready(function() {
  $(".tag_form").tagit({  // 指定のセレクタ( 今回は、:tag_list の text_field )に、tag-itを反映
    tagLimit:10,         // タグの最大数
    singleField: true,   // タグの一意性
 // availableTags: ['ruby', 'rails', ..]  自動補完する一覧を設定できる(※ 配列ならok)。今回は、Ajax通信でDBの値を渡す(後述)。
  });
  let tag_count = 10 - $(".tagit-choice").length    // 登録済みのタグを数える
  $(".ui-widget-content.ui-autocomplete-input").attr(
    'placeholder','あと' + tag_count + '個登録できます');
})

// タグ入力で、placeholder を変更
$(document).on("keyup", '.tagit', function() {
  let tag_count = 10 - $(".tagit-choice").length    // ↑ と同じなので、まとめた方がいい。
  $(".ui-widget-content.ui-autocomplete-input").attr(
  'placeholder','あと' + tag_count + '個登録できます');
});

  // 参:placeholderの書き換え方法
    $(".input").attr('placeholder','書き換え後のテキスト');
  // 参:placeholderの削除方法
    $(".input").removeAttr('placeholder');
    

$(document).on("keyup", '.tagit', function() {
  // Ajaxで、タグ一覧を取得
  let input = $(".ui-widget-content.ui-autocomplete-input").val();  // 変数inputに、入力値を格納
  console.log("OK");
  console.log(input);
  $.ajax({
    type: 'GET',
    url: 'get_tag_search',    // ルーティングで設定したurl
    data: { key: input },     // 入力値を:keyとして、コントローラーに渡す
    dataType: 'json'
  })

    .done(function (data) {
      console.log("done");
    if(input.length) {               // 入力値がある時のみ 
      let tag_list = [];             // 空の配列を準備
      data.forEach(function(tag) {   // 取得したdataのnameを配列に格納
        tag_list.push(tag.name);     // 1つずつ追加。 tag_list = ["タグ名1", "タグ名2", ..]
      });
      $(".tag_form").tagit({
        availableTags: tag_list
      });
    }
  })
});