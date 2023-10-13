# Cryptographic-Accelerator---SHA-256-Encryption
![image](https://github.com/MatanShemesh10/Cryptographic-Accelerator---SHA-256-Encryption/assets/122441156/cec361ea-022d-46a3-8da6-c07e91c75496)

In the RISC-V and Artificial Intelligence hackathon, we were tasked with implementing the SHA-256 encryption, which encrypts passwords by transforming and altering the content of strings.

![image](https://github.com/MatanShemesh10/Cryptographic-Accelerator---SHA-256-Encryption/assets/122441156/13060b93-bb7f-4c37-8333-d25aa8d4761c)

![image](https://github.com/MatanShemesh10/Cryptographic-Accelerator---SHA-256-Encryption/assets/122441156/29feaf00-7b8a-4096-8bc5-c85a34a2046b)

Since the algorithm involves numerous operations and lengthy computations, there is a need to reduce the execution time and resource consumption for the algorithm to perform efficiently. With the help of the AI accelerator, we aim to achieve our goal: reducing the execution time, obtaining faster results, and using fewer resources (by implementing it in Verilog).

The entire process was carried out using C files and Verilog files.

After receiving the C file that performs the algorithm's operations, we needed to transfer portions of the code to be executed in VERILOG according to the memory mapping.

In our case, we chose to implement the initialization stage (Init256SHA), which involves memory mapping, in VERILOG. This is how we initialized the program's states.

Following that, in the transformation stage (Transform256SHA), we decided to execute the data expansion and the bits (expander) in VERILOG. By implementing this part in VERILOG, we managed to save numerous loops that were required in the C code and achieved parallelism. This was possible by writing in a language close to the processor.

A brief description of the expander process within the VERILOG code:
We took the first "for" loop, where we find our 64 m-values, and observed that we could process the first 16 m-values within a single clock cycle, thereby saving clock cycles. We then needed to find the remaining m-values, and we found that we could obtain two additional m-values during each clock cycle, saving another half of the clock cycles. Essentially, with these two actions, we expedited the Transform256SHA.
