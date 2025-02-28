*** Settings ***
Documentation   Test case for demo-req001
...
...             demo-req001 states that system
...             shall run on Linux RHEL8 based OS
Resource        ../resources/req001.resource
Default Tags    demo-req001	req001

*** Test Cases ***
Assert That OS Is Linux
    [Documentation]     Uses python platform.system() to determine operating system
    Determine The Running OS
    Check If OS Is Linux

Assert That OS Is RHEL Based
    [Documentation]     Parses the file /etc/system-release
    ...
    ...                 /etc/system-release contains the name of the
    ...                 release. This is arbitrary but the first word
    ...                 contains the actual release name. This is tested
    ...                 against a list of known RHEL based OSes.
    Check If OS Is RHEL Based

Assert That OS Is Major Release 8
    [Documentation]     Parses the file /etc/os-release
    ...
    ...                 /etc/os-release contains a number of variables of
    ...                 which VERSION_ID is one. Fetching this value and store
    ...                 in a variable becomes tricky when in contains
    ...                 double quotes. This will split the string into
    ...                 option and value pair, store the pair and strip
    ...                 it of the double quotes. Then treat is a string
    ...                 and return the major version number.
    Check If OS Is Major Release 8
