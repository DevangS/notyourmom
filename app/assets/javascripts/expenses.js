/**
 *  * This is the worst JS you've ever seen.
 */

function getCsrfToken() {
    return $('meta[name=csrf-token]').attr('content');
}

var env = (function() {
    store = {};

    return {
        set: function(key, value) {
            store[key] = value;
            return true;
        },
        get: function(key) {
            return store[key];
        }
    };
})();

$(function() {
    var ns = (function(namespace) {
        return function(selector) {
            return namespace + ' ' + selector;
        }
    })('.ns_comments');

    function isOwnComment($commentNode) {
        return $commentNode.attr('data-user-id') == env.get('current-user-id');
    }

    // Fix for CSRF defense issue. We need to send this header with AJAX
    // form submissions.
    $(document).ajaxSend(function(e, xhr) {
        xhr.setRequestHeader('X-CSRF-Token', getCsrfToken());
    });

    // Hover and click behavior for comment controls
    function enableControls($comment) {
        var $this = $comment;

        if (isOwnComment($this)) {
            $this.hover(
                function() {
                    $this.find('.controls').show();
                },
                function() {
                    $this.find('.controls').hide();
                }
            ).find('.controls').each(function() {
                $(this).find('a')
                    .first().unbind('click').click(makeEditable)
                    .next().unbind('click').click(requestDelete);
            });
        }
    }
    $(ns('.comment')).each(function() {
        enableControls($(this));
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

        $.ajax({
            url: '/comments.json',
            type: 'POST',
            data: $.extend(
                {'comment[comment]': commentText},
                serializeForm()
            ),
            error: function(jqxhr, textStatus, errorThrown) {
                rollBack(comment);
            },
            success: function(response) {
                console.log(response);
                comment
                    .attr('data-id', response.id)
                    .attr('data-user-id', response.user_id);
                enableControls($(comment));
            }
        });
    }

    function addLocally(commentText) {
        var template = $('#comment-template')
                .html().replace('{text}', commentText),
            comment = $(template);

        comment.find('.controls a')
            .first().click(makeEditable)
            .next().click(requestDelete);

        return comment.hide().appendTo($(ns('#inline-comments'))).fadeIn();
    }

    function rollBack(comment) {
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
    }

    function requestDelete() {
        var comment = $(this).closest('.comment');

        comment.fadeOut('fast', function() {
            comment.hide();
        });

        $.ajax({
            url: '/comments/' + comment.attr('data-id'),
            type: 'POST',
            data: {
                id: comment.attr('data-id'),
                '_method': 'delete'
            },
            error: function() {
                comment.fadeIn('fast', function() {
                    comment.show();
                });
            },
            success: function() {
                comment.remove();
            }
        });

        return false;
    }

    function makeEditable() {
        function cancelEditing() {
            commentText
                .text(initialText)
                .removeAttr('contenteditable')
                .blur();
        }

        var comment = $(this).closest('.comment'),
            commentText = $(this).parent().siblings('.comment-text'),
            initialText = $.trim(commentText.text());

        console.log('attr is', commentText.attr('contenteditable'))
        if (commentText.attr('contenteditable') !== undefined) {
            console.log('canceled');
            cancelEditing();
            return;
        }

        commentText
            .attr('contenteditable', true)
            .focus()
            .keydown(function(e) {
                if (e.keyCode === 13) {
                    // Enter key pressed
                    commentText.removeAttr('contenteditable');
                    $.ajax({
                        url: '/comments/' + comment.attr('data-id'),
                        type: 'POST',
                        data: {
                            'comment[comment]': $.trim($(this).text()),
                            'comment[user_id]': comment.attr('data-user-id'),
                            'comment[expense_id]': env.get('expense-id'),
                            '_method': 'put'
                        },
                        error: function() {
                            commentText.text(initialText);
                        }
                    });
                }
                else if (e.keyCode === 27) {
                    // Esc key pressed
                    cancelEditing();
                }
            });

        return false;
    }
});