#!/usr/bin/env fish
# Generate a changelog entry based on the semantic commit log from the last tag
#
# Usage:
#     gen-changelog
#
# To insert in vim:
#
#     :read !gen-changelog
function gen-changelog
	set LAST_TAG (git describe --tags --abbrev=0)
    echo
    echo "### Enhancements"
    git log $LAST_TAG..HEAD --pretty='format:%n* %s%n  %an' --grep='^feat'
    echo
    echo "### Bug fixes"
    git log $LAST_TAG..HEAD --pretty='format:%n* %s%n  %an' --grep='^fix'
    echo
end

