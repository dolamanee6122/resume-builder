$(document).ready(function () {
    $('input[type="file"]').change(function () {
        var image = webkitURL.createObjectURL(this.files[0]);
        $("#image-preview").attr("src", image);
    });
});