import scapy.all as scapy
import random
import sys

def drop_traffic(packet, drop_percentage):
    """
    Function to drop a percentage of incoming packets randomly.
    """
    if random.random() < drop_percentage / 100:
        print(f"Dropped packet: {packet.summary()}")
        return

    # If the packet is not dropped, forward it
    scapy.send(packet)

def main(drop_percentage):
    """
    Main function to start sniffing and dropping traffic.
    """
    print("Sniffing traffic on interface ens3.")
    scapy.sniff(iface="ens3", prn=lambda x: drop_traffic(x, drop_percentage))

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <drop_percentage>")
        sys.exit(1)

    drop_percentage = float(sys.argv[1])
    if drop_percentage < 0 or drop_percentage > 100:
        print("Drop percentage must be between 0 and 100.")
        sys.exit(1)

    main(drop_percentage)
