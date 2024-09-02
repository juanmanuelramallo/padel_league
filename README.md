# Padel League

[![CI](https://github.com/juanmanuelramallo/padel_league/actions/workflows/ci.yml/badge.svg)](https://github.com/juanmanuelramallo/padel_league/actions/workflows/ci.yml)

## Edit credentials

### Production

```bash
RAILS_ENV=production bundle exec rails credentials:edit
```

### Development

```bash
RAILS_ENV=development bundle exec rails credentials:edit
```

## Git Hooks

```bash
git config --local core.hooksPath .githooks
```
