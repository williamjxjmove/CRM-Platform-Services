
Summary:        my script
Name:           %{rpmname}
Version:        %{rpmversion}
Release:        %{rpmrelease}
License:        none
Source:         %{name}.tar.gz
BuildArch:      %{rpmarch}
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root
Group:          Applications
Vendor:         MOVE.inc

%define _installpath	%{installpath}
%define _topdir		%{rpmtopdir}

%description
RPM package for CRM-Platform-Services. Spec file also creates tmp directory
and touch the file restart.txt

%prep
%setup -n %{name}
echo "tmppath = %{_tmppath}"
echo "name = %{name}"
echo "version = %{version}"
echo "release = %{release}"
echo "topdir = %{_topdir}"
echo "RPM build root = $RPM_BUILD_ROOT"
echo "builddir = %{_builddir}"
echo "rpm dir = %{_rpmdir}"
echo "rpm filename = %{_rpmfilename}"
echo "install path = %{_installpath}"

%build

%install
mkdir -p $RPM_BUILD_ROOT/%{_installpath}
cd %{_topdir}/BUILD/%{name}
tar -cpvf - .|(cd $RPM_BUILD_ROOT/%{_installpath}/;tar -xpvf -)
mkdir $RPM_BUILD_ROOT/%{installpath}/tmp
touch $RPM_BUILD_ROOT/%{installpath}/tmp/restart.txt

%clean
rm -rf $RPM_BUILD_ROOT
rm -rf %{_tmppath}/%{name}
rm -rf %{_topdir}/BUILD/%{name}

%files
%defattr(755,root,root)
%attr(755,railssvc,railssvc) %{_installpath}

# if we have system files in /bin for example
# we can use wildcard. will only select files that are in BuildRoot
# /bin/*

%post
# %{_installpath}/scripts/test.sh

%changelog
* Fri Mar 08 2013 Gregor Philp
- new file for CRM-Platform-Services

