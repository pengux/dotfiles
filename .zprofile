# SSH agent
eval $(ssh-agent)
# # set SSH_AUTH_SOCK env var to a fixed value
# export SSH_AUTH_SOCK=~/.ssh/ssh-agent.sock
#
# # test whether $SSH_AUTH_SOCK is valid
# ssh-add -l 2>/dev/null >/dev/null
#
# # if not valid, then start ssh-agent using $SSH_AUTH_SOCK
# [ $? -ge 2 ] && ssh-agent -a "$SSH_AUTH_SOCK" >/dev/null
