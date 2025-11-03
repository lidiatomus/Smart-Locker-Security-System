# Smart-Locker-Security-System
🧠 Overview

The system acts as a smart locker access controller, similar to digital lockers in gyms or malls.
Users can create and validate a personal 4-character code (0–9, A–F).
The locker automatically locks and unlocks based on the entered code, with visual indicators showing system state.

✨ Key Features

🔢 4-character cipher input via Digilent Pmod Keypad

💡 Status LEDs:

FREE_LOCKER (green): locker available

LED_LOCKED (red): locker secured

🧮 7-Segment Display (SSD): shows code input progress

🔁 Debounced Input: ensures stable keypad signals

🧰 Reset Switch (RST): resets to initial unlocked state

🔐 Code Verification: compares input sequence with stored cipher

⚙️ Structural VHDL Design: modular components for clarity and debugging

⚙️ Hardware Components
Component	Function
Basys 3 FPGA Board	Main logic and control
Pmod KYPD Keypad	User input (0–F keys)
LEDs	Locker state indicators
7-Segment Display (SSD)	Visual code feedback
RST Switch	System reset control
🧩 Functional Workflow

Idle State:

SSD displays 0000

Green LED (FREE_LOCKER) ON → locker available

Setting a Code:

User enters 4 characters via keypad

Each press confirmed with BTN

After 4 inputs → locker locks, red LED ON

Unlocking:

User re-enters the same 4-character code

System compares input with stored cipher

If matched → locker unlocks, green LED ON

Reset:

Pressing RST resets the locker and clears memory

🧱 System Architecture
SmartLocker/
├── debouncer.vhd
├── button_counter.vhd
├── display_controller.vhd
├── register_shift.vhd
├── main_locker.vhd
└── README.md


Main Components:

debouncer.vhd – filters noisy button inputs

button_counter.vhd – counts button presses (0–3)

register_shift.vhd – stores and shifts cipher digits

display_controller.vhd – handles SSD visualization

main_locker.vhd – integrates all modules, controls LEDs and logic

🧠 Design Insights

This project was developed using VHDL in Vivado and implemented on the Basys 3 FPGA.
A structural design approach was chosen to maintain modularity and simplify debugging.
Each component was individually tested and integrated through port mapping for clean, maintainable code.

🛠️ Future Improvements

✨ Blinking cursor on SSD for current digit entry

⏱️ Limit of 3 wrong attempts → temporary lockout

🔒 “Frozen Locker” LED for multiple failed attempts

🔄 Partial reset for current digit only

⚙️ Compatibility with other FPGA boards (e.g., Nexys A7)

👩‍💻 Author

Lidia Tomuș
💻 Developer of Smart Locker Security System
🔗 Passionate about embedded design, digital logic, and FPGA-based solutions
