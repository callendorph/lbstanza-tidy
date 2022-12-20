#ifndef FORCE_ULONG
#define FORCE_ULONG

// The tidyplatform.h file introduces the `ulong` definition for everything except
//   linux on line 580 or so. The pycparser implementation fake headers doesn't
//   include the ulong definition. So I'm using this as a bit of a hack to
//   process the headers smoothly.

#undef ulong
typedef unsigned long ulong;

#endif
