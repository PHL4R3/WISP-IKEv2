import subprocess
import random
import sys
import time

def drop_traffic(drop_percentage):
    """
    Function to drop a percentage of incoming and outgoing packets randomly using iptables.
    """
    # Flush existing iptables rules
    subprocess.call(["iptables", "-F"])

    # Set up iptables rule to drop outgoing packets
    subprocess.call(["iptables", "-A", "OUTPUT", "-m", "statistic", "--mode", "random", "--probability", str(drop_percentage/100), "-j", "DROP"])

    # Set up iptables rule to drop incoming packets
    subprocess.call(["iptables", "-A", "INPUT", "-m", "statistic", "--mode", "random", "--probability", str(drop_percentage/100), "-j", "DROP"])

    print(f"Dropping {drop_percentage}% of incoming and outgoing packets...")
    print("Press Ctrl+C to stop dropping packets.")
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        print("Stopping packet dropping...")
        # Flush iptables rules
        subprocess.call(["iptables", "-F"])
        print("All iptables rules have been cleared.")

def main(drop_percentage):
    """
    Main function to start dropping traffic.
    """
    if drop_percentage < 0 or drop_percentage > 100:
        print("Drop percentage must be between 0 and 100.")
        sys.exit(1)

    drop_traffic(drop_percentage)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <drop_percentage>")
        sys.exit(1)

    drop_percentage = float(sys.argv[1])
    main(drop_percentage)