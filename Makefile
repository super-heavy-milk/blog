# # list recipies
# default:
#     @just --list

.PHONY: dev
# run a hot reload dev server
dev:
	hugo server -D

# create a new blog entry e.g. 'my-post.md'
# blog entry:
#     hugo new content "{{ justfile_directory() }}/content/posts/{{ entry }}"

.PHONY: lint
# run all the pre-commit hooks
lint:
	pre-commit run --all-files --hook-stage manual

# # format the justfile
# fmt-justfile:
#     just --fmt --unstable
