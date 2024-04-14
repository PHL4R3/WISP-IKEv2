import subprocess
import sys
import time

def drop_traffic(drop_percentage):
    """
    Function to drop a percentage of incoming and outgoing packets for port 4500 using iptables.
    """
    # Flush existing iptables rules
    subprocess.call(["iptables", "-F"])

    # Set up iptables rule to drop outgoing packets for port 4500
    subprocess.call(["iptables", "-A", "OUTPUT", "-p", "tcp", "--dport", "4500", "-m", "statistic", "--mode", "random", "--probability", str(drop_percentage/100), "-j", "DROP"])
    subprocess.call(["iptables", "-A", "OUTPUT", "-p", "udp", "--dport", "4500", "-m", "statistic", "--mode", "random", "--probability", str(drop_percentage/100), "-j", "DROP"])

    # Set up iptables rule to drop incoming packets for port 4500
    subprocess.call(["iptables", "-A", "INPUT", "-p", "tcp", "--sport", "4500", "-m", "statistic", "--mode", "random", "--probability", str(drop_percentage/100), "-j", "DROP"])
    subprocess.call(["iptables", "-A", "INPUT", "-p", "udp", "--sport", "4500", "-m", "statistic", "--mode", "random", "--probability", str(drop_percentage/100), "-j", "DROP"])

    print(f"Dropping {drop_percentage}% of incoming and outgoing packets for port 4500...")
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
    Main function to start dropping traffic for port 4500.
    """
    drop_traffic(drop_percentage)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <drop_percentage>")
        sys.exit(1)

    drop_percentage = float(sys.argv[1])
    main(drop_percentage)
