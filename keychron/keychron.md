# Keychron 4 BlueTooth Keyboard

This keyboard has some difficulties with inescapable numlock mode being engaged in windows and <br />
linux OS. To solve;

<ul>
  <li>
    Add the config file in this folder to /etc/modprobe.d/
  </li>
  <li>
    type `sudo update-initramfs -u` and reboot
  </li>
</ul>

Now, if numlock is ever engaged, double-tapping `F6` should disable it.

