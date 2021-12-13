vcf_sources = [
  'vcf-closures.vala',
  'vcf-collection.vala',
  'vcf-concat-collection.vala',
  'vcf-delegates.vala',
  'vcf-equatable.vala',
  'vcf-flat-collection.vala',
  'vcf-hashable.vala',
  'vcf-iterable.vala',
  'vcf-iterator.vala',
  'vcf-list.vala',
  'vcf-map.vala',
  'vcf-mapped-collection.vala',
  'vcf-skip-collection.vala',
  'vcf-skip-while-collection.vala',
  'vcf-stringifiable.vala',
  'vcf-take-collection.vala',
  'vcf-take-while-collection.vala',
  'vcf-utils.vala',
  'vcf-where-collection.vala',
]

vcf_deps = [
  dependency('glib-2.0', version : '>=2.50'),
  dependency('gobject-2.0', version : '>=2.50'),
]

vcf_vala_flags = [
  '--abi-stability',
  '--hide-internal',
  '--enable-checking',
  '--nostdpkg',
]

vcf = library(
  'vcf',
  vcf_sources,

  vala_args    : vcf_vala_flags,
  dependencies : vcf_deps,
  install      : true,
)

vcf_dep = declare_dependency(
  link_with           : vcf,
  dependencies        : vcf_deps,
  include_directories : '.',
)
