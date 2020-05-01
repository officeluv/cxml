# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
### Changed
### Deprecated
### Removed
### Fixed
### Security

---

## [0.6.0] - 2020-05-01
### Fixed
- Conform to cXML DTD spec for ordered output of child nodes.
### Added
- Support parsing and validating output against DTDs in specs.

## [0.5.0] - 2020-04-30
### Added
- Support parsing and specifying different DTDs.

## [0.4.0] - 2020-04-20
### Changed
- Return parsed nodes as plain string if they have no attributes and only string content.

## [0.3.0] - 2020-04-19
### Changed
- Drop Nokogiri and XMLSimple in favor of Ox.
- Change Parser class interface to be OO.
