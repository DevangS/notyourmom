# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file:
# http://jashkenas.github.com/coffee-script/

$(function() {
    $('form').submit(function(e) {
        postComment($('#comment').val());
        $('#comment').val('');
        e.preventDefault();
    });

    function postComment(text) {
        var commentText = text || $('#comment').val(),
            comment = addLocally(commentText);

        $.post(
            '/expenses',
            $.extend({comment: commentText}, serializeForm()),
            function(response) {
                $.parseJSON(response).success === false && rollBack(comment);
            }
        );
    }

    function addLocally(commentText) {
        return $('<div/>', {class: 'comment'})
            .text(commentText)
            .hide()
            .appendTo($('#comments'))
            .fadeIn();
    }

    function rollBack(comment) {
        showError(comment);
    }

    function serializeForm() {
        var fields = {};

        $('#inline-comment-form input').each(function() {
            var field = $(this);
            if (field.attr('name') !== 'comment') {
                fields[field.attr('name')] = field.val();
            }
        });

        return fields;
    }

    function showError(comment) {
        var errorWrapper = $('<div/>', {class: 'failedComment'}),
            message = $('<span/>', {class: 'uhoh'}).text(
                'Your comment failed to send. Heads will roll for this.'
            ),
            retryLink = $('<a/>', {href: '#'}).text('Retry').click(function() {
                postComment(comment.text());
                comment.closest('.failedComment').fadeOut().remove();
            });

        comment.replaceWith(errorWrapper.append(message).append(retryLink));
        errorWrapper.prepend(comment);
    }
});