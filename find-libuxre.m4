# Search libuxre
AC_DEFUN([HEIRLOOM_FIND_LIBUXRE],[
use_included_libuxre=no
AC_ARG_WITH([libuxre],
AS_HELP_STRING([--with-libuxre=prefix-to-builddir-libuxre],
  [path to the builddir of libuxre]),
  [libuxre_prefix=${withval}],
  [libuxre_prefix=../heirloom-libuxre])

AC_MSG_CHECKING([libuxre.a])
if test -r "${libuxre_prefix}/libuxre.a"
then
  AC_MSG_RESULT([${libuxre_prefix}/libuxre.a])
  libuxre_lib="${libuxre_prefix}"
elif test -r ${libuxre_prefix}/lib/libuxre.a
then
  AC_MSG_RESULT([${libuxre_prefix}/lib/libuxre.a])
  libuxre_lib="${libuxre_prefix}/lib"
fi

if test x"${libuxre_lib}" != x
then
  orig_LIBS="${LIBS}"
  LIBS="-L${libuxre_lib} -luxre"
  AC_CHECK_FUNC([libuxre_regdelnfa],[],[libuxre_lib=""])
  LIBS="${orig_LIBS}"
fi

if test x"${libuxre_lib}" = x
then
  AC_MSG_WARN([no usable libuxre found, use included copy of heirloom-libuxre])
  use_included_libuxre=yes
  libuxre_prefix="${srcdir}"/heirloom-libuxre/
  libuxre_include='$(libuxre_prefix)'
  libuxre_lib='$(libuxre_prefix)'
fi

AC_MSG_CHECKING([regex.h])
if test "${use_included_libuxre}" = yes
then
  AC_MSG_RESULT([build from included source])
elif test -r "${libuxre_prefix}"/regex.h
then
  AC_MSG_RESULT([${libuxre_prefix}/regex.h])
  libuxre_include="${libuxre_prefix}"
elif test -r ${libuxre_prefix}/include/regex.h
then
  AC_MSG_RESULT([${libuxre_prefix}/include/regex.h])
  libuxre_include='$(libuxre_prefix)/include'
else
  AC_MSG_ERROR([not found])
fi

AM_CONDITIONAL(BUILD_LIBUXRE, test "${use_included_libuxre}" = yes)
AC_SUBST([libuxre_prefix])
AC_SUBST([libuxre_include])
AC_SUBST([libuxre_lib])

])
