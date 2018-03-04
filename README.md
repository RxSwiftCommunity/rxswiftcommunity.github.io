[community.rxswift.org](http://community.rxswift.org)
=========================================================

[![Build Status](https://travis-ci.org/RxSwiftCommunity/rxswiftcommunity.github.io.svg?branch=source)](https://travis-ci.org/RxSwiftCommunity/rxswiftcommunity.github.io)

<center><img src="http://rxswiftcommunity.github.io/images/logo.svg" height="250" /></center>

<br/>

Website for projects that support RxSwift.

## Adding a new project

The site is generated from [this file](https://github.com/RxSwiftCommunity/rxswiftcommunity.github.io/blob/source/data/items.yml); add new projects there in YAML format.

When adding a new GitHub repository, there is no need to manually set `stargazers`, `watchers` or `updated_at` since these are updated automatically. Your basic "item" should look like so and be added to the appropriate section:

```yaml
- name: YourProject
  repo: YourOrganization/YourProject
  description: A description of your project
```

If you get stuck, just open an issue!

## Contributing

1. Fork the project.
2. Clone it locally.
3. Run `bundle install`
4. Use `middleman` and browse to [localhost:4567](localhost:4567) to preview changes.
5. Open a PR 🎉  targeting the source branch

## Deploying

Deploying is handled automatically when a commit is made to the `source` branch.

## Thanks

Thanks to [this project](https://github.com/IronSummitMedia/startbootstrap-modern-business) for the bootstrap theme.
