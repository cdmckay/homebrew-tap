# cdmckay's Homebrew tap

## credlock

[credlock](https://github.com/cdmckay/credlock) hands secrets from 1Password
to one command at a time, after you have seen which secrets are asked for, by
whom, and why. macOS only.

```bash
brew install cdmckay/tap/credlock
```

Homebrew builds it from source, so the first install takes a minute. Then, in
1Password, open **Settings → Developer** and, under **Integrate with the
1Password SDKs**, choose **Integrate with other apps**.

## How the formula is kept up to date

The autobump workflow checks for a new credlock release every day and opens a
pull request that updates the formula. The tests workflow builds and tests the
formula on each pull request. A pull request opened by the autobump workflow
doesn't start the tests on its own, because GitHub doesn't run workflows for
its own token's pull requests: close and reopen it to run them. The release
process is in credlock's
[RELEASING.md](https://github.com/cdmckay/credlock/blob/main/RELEASING.md).
