*** Settings ***
Library		String
Library		OperatingSystem

*** Variables ***
${RHEL_BASED_OS}    Rocky   AlmaLinux   RedHat  CentOS

*** Keywords ***
Determine The Running OS
    [Documentation]     Uses python platform.system() to determine operating system
    ${system_os}=       Evaluate    platform.system()
    Return ${system_os}

Check If OS Is Linux
    [Documentation]     Uses python platform.system() to determine operating system
    ${system_os}=       Evaluate    platform.system()
    Should Be Equal     ${system_os}     Linux

Check If OS Is RHEL Based
    [Documentation]     Parses the file /etc/system-release
    ...
    ...                 /etc/system-release contains the name of the
    ...                 release. This is arbitrary but the first word
    ...                 contains the actual release name. This is tested
    ...                 against a list of known RHEL based OSes.
    ${system_release_file_contents}=     Get File    /etc/system-release
    ${system_dist_list}=        Split String    ${system_release_file_contents}
    Should Contain      ${RHEL_BASED_OS}    ${system_dist_list}[0]

Check If OS Is Major Release 8
    [Documentation]     Parses the file /etc/os-release
    ...
    ...                 /etc/os-release contains a number of variables
    ...                 VERSION_ID is one. Fetching this value and store
    ...                 in a variable becomes tricky when in contains
    ...                 double quotes. This will split the string into
    ...                 option and value pair, store the pair and strip
    ...                 it of the double quotes. Then treat is a string
    ...                 and return the major version number.
    ${version_id}=      Grep File   /etc/os-release     VERSION_ID
    ${version_id_list}=         Split String	${version_id}	=
    ${version_major}=	Strip String	${version_id_list}[1]	both	\"
    ${version_major}=	Fetch From Left		${version_major}	.
    Should Be Equal     ${version_major}   8
