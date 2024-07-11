# Exercism Test Runner Template

This repository is a [template repository](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-template-repository) for creating [test runners][test-runners] for [Exercism][exercism] tracks.

To create a new test runner, use the `bin/bootstrap.sh` script:

```shell
LANGUAGE=Ruby SLUG=ruby bin/bootstrap.sh
```

This will automatically:

1. Create the test runner repository
1. Setup access for the `maintainers-admin` team and the track-specific team
1. Setup branch protection rules
1. Give this repository access to the secrets required to deploy the image
1. Disable merge and rebase commits

## Future work

Once the test runner is ready to be tested, you need to:

- Manually push the image to Docker hub
- Create a pull request to the [exercism/terraform][terraform] repository
  - Once merged, provision the latest version to the servers and manually trigger the deploy workflow

[terraform]: https://github.com/exercism/terraform/
