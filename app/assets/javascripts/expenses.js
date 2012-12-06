/**
 *  * This is the worst JS you've ever seen.
 */

function getCsrfToken() {
    return $('meta[name=csrf-token]').attr('content');
}

$(function() {
    var ns = (function(namespace) {
        return function(selector) {
            return namespace + ' ' + selector;
        }
    })('.ns_comments');

    // Fix for CSRF defense issue. We need to send this header with AJAX
    // form submissions.
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
        console.log('postComment');
        var commentText = text || $(ns('#comment')).val(),
            comment = addLocally(commentText);

        $.ajax({
            url: '/comments.json',
            type: 'POST',
            data: $.extend(
                {'comment[comment]': commentText},
                serializeForm()
            ),
            error: function(jqxhr, textStatus, errorThrown) {
                rollBack(comment);
            }
        });
    }

    function addLocally(commentText) {
        console.log('addLocally');
        var template = $('#comment-template')
            .html()
            .replace('{text}', commentText);
        console.log(template);


        return $(template).hide().appendTo($(ns('#inline-comments'))).fadeIn();
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

/*    function showError(comment) {
        var errorTemplate = $($('#rejected-comment-template').html());

        errorTemplate.find('.failedComment').prepend(comment);
        errorTemplate.append

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
    }*/

    function showError(comment) {
        console.log('showError');
        var errorTemplate = $($('#rejected-comment-template').html()),
            retryLink = $('<a/>', {href: '#'}).text('Click to retry').click(
                function() {
                    var commentText = comment.find('.comment-text').text();

                    $(this).closest(ns('.failedComment')).fadeOut(
                        'fast',
                        function() {
                            $(this).remove();
                            postComment(commentText);
                        }
                    );

                    return false;
                }
            ),
            commentContents = comment.clone();

        errorTemplate.append(retryLink);
        errorTemplate.prepend(commentContents);
        comment.replaceWith(errorTemplate);

/*        comment.replaceWith(
            errorTemplate
                .append(retryLink)
                .find('.failedComment')
                .prepend(commentContents)
        );*/
    }
});