(function(){$(function(){var t,a,e,n;return $(".post-type").on("change",function(){var t,a;return $.ajax({url:$(this).data("formPath"),type:"post",data:{"post[type]":$(this).val()}}).done(function(t){return a(t)}).fail(function(){return t()}),a=function(t){return $("#post-form").html(t)},t=function(){return console.log("Failed to load post form.")}}),$(".asset").each(function(t,e){return $(e).tipsy({fallback:"Click to see image URL",fade:!0}),$(e).on("click",function(){return a($(this)),$(".asset-url").val($(this).attr("src")),$(".remove-asset").data("assetId",$(this).attr("data-asset-id"))}),$(".remove-asset").on("click",function(){return $(".asset[data-asset-id="+$(this).data("assetId")+"]").remove(),$(".asset-url").val("")})}),a=function(t){return $(".asset.active").removeClass("active"),t.addClass("active")},$(".add-asset").on("ajax:success",function(a,e){return t(e)}),t=function(t){return e(!0),$(".dim").append(t)},e=function(t){return $(".dim").length>0||n(),t?$(".dim").fadeIn("fast"):$(".dim").fadeOut("fast")},n=function(){return $("#main").prepend('<div class="dim"></div>')}})}).call(this);