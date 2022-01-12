$(document).ready(function () {
    $('input[type="file"]').change(function () {
        var image = webkitURL.createObjectURL(this.files[0]);
        $("#image-preview").attr("src", image);
    });

    $("#clipboard-btn").on("click", function () {
        $("#clipboard-btn").text("Copied!");
        navigator.clipboard.writeText(this);
        return false;
    });
});