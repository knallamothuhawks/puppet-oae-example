#
# User and group resources for Kaleidoscope SIS integration
#
class people::kaleidoscope::internal {
    include people::kaleidoscope

    realize(Group['scp_internal'])
    realize(User['scp_internal'])
    realize(Ssh_authorized_key['scp_internal-pub'])
}

class people::kaleidoscope::external {
    include people::kaleidoscope

    realize(Group['kaleidoscope'])
    realize(User['kaleidoscope'])
    realize(Ssh_authorized_key['kaleidoscope-pub'])
    realize(Ssh_authorized_key['kaleidoscope-pub-real'])
    realize(Ssh_authorized_key['kaleidoscope-pub-real2'])
}

class people::kaleidoscope {

    include rssh

    @group { 'scp_internal' : gid => '815' }
    @user { 'scp_internal':
        ensure     => present,
        uid        => '815',
        gid        => 'scp_internal',
        home       => '/home/scp_internal',
        managehome => true,
        groups     => ['scp_internal','rsshusers'],
        shell      => '/usr/bin/rssh'
    }
    @ssh_authorized_key { 'scp_internal-pub':
        ensure => present,
        key  => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAzf5fTjX14VZ3cukhr7Fx/adRx2btms0/FQHcqtLywg05sHG8Kao5zCL/oprXQ+moKipBDeEujmJ2WDpbweaWBPaADNRSHm0Qly5sMGTz2erK7e/lRxGpx7GVcqVT/eoVMq7CZSp+i4mr0rp9H/nyxpEP1Dpltb5PtEup0ECV7oNxnfJgF6Rr8lwXp6mOUq3mw78Hkbil6bdtG1NHq2L6+x5j7nIt8OVd2Mtb0CVZ7hdaAojNDy2BWCq5OrLbuheYRakUOWZfIFAWyN7jDvOWAM1Bu0pQ2QgpyodS2v0g+t8HYABQVO7By55+uYqAbJOwwDqYIfJq5KqNhGy3DnIacw==',
        type => 'ssh-rsa',
        user => 'scp_internal',
        require => User['scp_internal'],
    }

    @group { 'kaleidoscope' : gid => '816' }
    @user { 'kaleidoscope':
        ensure     => present,
        uid        => '816',
        gid        => 'kaleidoscope',
        home       => '/home/kaleidoscope',
        managehome => true,
        groups     => ['kaleidoscope','rsshusers'],
        shell      => '/usr/bin/rssh'
    }
    @ssh_authorized_key { 'kaleidoscope-pub':
        ensure => absent,
        key  => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAzf5fTjX14VZ3cukhr7Fx/adRx2btms0/FQHcqtLywg05sHG8Kao5zCL/oprXQ+moKipBDeEujmJ2WDpbweaWBPaADNRSHm0Qly5sMGTz2erK7e/lRxGpx7GVcqVT/eoVMq7CZSp+i4mr0rp9H/nyxpEP1Dpltb5PtEup0ECV7oNxnfJgF6Rr8lwXp6mOUq3mw78Hkbil6bdtG1NHq2L6+x5j7nIt8OVd2Mtb0CVZ7hdaAojNDy2BWCq5OrLbuheYRakUOWZfIFAWyN7jDvOWAM1Bu0pQ2QgpyodS2v0g+t8HYABQVO7By55+uYqAbJOwwDqYIfJq5KqNhGy3DnIacw==',
        type => 'ssh-rsa',
        user => 'kaleidoscope',
        require => User['kaleidoscope'],
    }
    @ssh_authorized_key { 'kaleidoscope-pub-real':
        ensure => absent,
        key  => 'AAAAB3NzaC1kc3MAAACBAMBGcIYKqrR/W0naV4zw8SMX4Pe0FyGVw5O+E+WqileyI7KYOeO9bDvZiMi/zXL7s9c5tIoZIROZejL4+/uBCRcXVv/bf+w5XlnIRocRLpTCx3YkbZYL9eJB2aGAiEa/9bI1djFc99P9Li1JYx5v9Se9eNj+o1uayV9xtgNPWukTAAAAFQCpz7X2h7CUdvDLtxxpqn5vaYUYswAAAIB8NOhOrV4eKY/Xq3E9jYPydFumdFm4UC1Lc9Aemr0WmfW6tRsowRYNm4UsCg34ZvvUdBXVwOkPtT3MwJnAgVTJ3w85IqK5j4LbSHl4Caxm6ccLN7egeTHU8zw9NfDheeAgR21YhAdWrYzA4mLlwT9iezUAbqDLgPkyVlCVXTVgpAAAAIAnqBaZSw7544zgNQSooOyF4TasHAiOl0txNg/fg7iOm/ltfsCQUzZjE4OApCj+inLp0aL3Nu6rmAhoixxpE/+TS6xxQDSgjA7THaiOnZuipIkO4HMkNY9Z1qapiNULy0bAZje68r3Cx4Jf5j8B8P9djldjwM6VUdmNtIth7Cy0BA==',
        type => 'ssh-dss',
        user => 'kaleidoscope',
        require => User['kaleidoscope'],
    }
    @ssh_authorized_key { 'kaleidoscope-pub-real2':
        ensure => present,
        key  => 'AAAAB3NzaC1kc3MAAACBAJrlvqcHHmF2xPNxrsINm+RqMe1AF5DTyYUVE0PzAejRBy7/7L8fI1nBkyrQ8Qi6l8gPkna8nhlVF6FmitFf/zEWIH7MAV22mso+ZNJ2ZVvMGGY0VUL82sQyHWL5Pt2HnBoQbKfxqruXvqPfmXQ/eeRfqazF2IVeanytvE/ggPMLAAAAFQCJNqakjbPlUraXIqu8H5Zhcp2HIwAAAIAg8jn5Vt3n4xHNQlrUax6GOtm2IXa3NgbCKx7UhCRwIB7K5pw6vV0LyrIxf+sVrFar0Ob/BURSyh4xE/4N85q2sVJiuBFXaKG612IMgZ+AaBXEGUE88KB2itU66nxy5qW4VVtDjT0GH7WXbpswwbOE1DQ6rhpjmfFVHKd1Eyi3UAAAAIA4oW2teLwPFWAgjIdRv2VvrI85PL7UCfXy0Kp0r4AUfcHPDi7FEmYI4QzzJf9r90lX4e2bDnqcxgiWhFuITP0nOCS4Tqf4zojU5DJEshUXlKJM+3ZphAtaOCZWyfl7l19PXHGFO0MCQtT7hdHjJ23kK8/QhkFFfv96KIfC8lh9Rg==',
        type => 'ssh-dss',
        user => 'kaleidoscope',
        require => User['kaleidoscope'],
    }
}
