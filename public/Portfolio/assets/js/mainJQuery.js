$(document).ready(function () {
    //Animation de scrollspy
    $('li>a').on('click', function(e) {
        e.preventDefault();
        var hash = this.hash;
        $('html, body').animate({
            scrollTop: $(this.hash).offset().top
        }, 1000, function(){
            window.location.hash = hash;
        });
    });

        $("[rel='tooltip']").tooltip();

    $('.thumbnail').hover(
        function(){
            $(this).find('.caption').slideDown(250); //.fadeIn(250)
        },
        function(){
            $(this).find('.caption').slideUp(250); //.fadeOut(205)
        }
    );
});
