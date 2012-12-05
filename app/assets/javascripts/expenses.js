function getCsrfToken() {
    return $('meta[name=csrf-token]').attr('content');
}

$(function() {
    var ns = (function(namespace) {
        return function(selector) {
            return namespace + ' ' + selector;
        }
    })('.ns_comments');

    // Fix for overzealous CSRF defense
    $(document).ajaxSend(function(e, xhr) {
        xhr.setRequestHeader('X-CSRF-Token', getCsrfToken());
    });

    $(ns('form')).submit(function(e) {
        var commentField = $(ns('#comment'));

        postComment(commentField.val());
        commentField.val('');

        e.preventDefault();
    });

    function postComment(text) {
        var commentText = text || $(ns('#comment')).val(),
            comment = addLocally(commentText);

        $.post(
            '/comments.json',
            $.extend({'comment[comment]': commentText}, serializeForm()),
            function(response) {
                console.log($.parseJSON(reponse));
                $.parseJSON(response).success == false && rollBack(comment);
            },
            function(reponse) {
                console.log('error' + reponse);
            }
        );
    }

    function addLocally(commentText) {
        return $('<div/>', {class: 'comment'})
            .text(commentText)
            .hide()
            .appendTo($(ns('#inline-comments')))
            .fadeIn();
    }

    function rollBack(comment) {
        console.log('rollback called');
        showError(comment);
    }

    function serializeForm() {
        var fields = {
            authenticity_token: getCsrfToken()
        };

        $(ns('#inline-comment-form input')).each(function() {
            var field = $(this);
            if (field.attr('name') !== 'comment[comment]') {
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
                comment.closest(ns('.failedComment')).fadeOut().remove();
            });

        comment.replaceWith(errorWrapper.append(message).append(retryLink));
        errorWrapper.prepend(comment);
    }
});