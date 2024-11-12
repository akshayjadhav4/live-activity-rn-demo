import { Button, Text, View } from "react-native";
import {
  areActivitiesEnabled,
  endActivity,
  startActivity,
  updateActivity,
  PackageStatus,
  addOrderCancelEventListener,
} from "local:order-tracking";
import { useEffect, useState } from "react";
export default function Index() {
  const [currentStatus, setCurrentStatus] = useState<PackageStatus>(
    PackageStatus.Shipped
  );

  function updateStatus(_currentStatus: string) {
    switch (_currentStatus) {
      case PackageStatus.Shipped:
        updateActivity({
          packageStatus: PackageStatus.InTransit,
          estimatedDeliveryTime: Math.floor(Date.now() / 1000),
        });
        setCurrentStatus(PackageStatus.InTransit);
        break;
      case PackageStatus.InTransit:
        updateActivity({
          packageStatus: PackageStatus.OutForDelivery,
          estimatedDeliveryTime: Math.floor(Date.now() / 1000),
        });

        setCurrentStatus(PackageStatus.OutForDelivery);
        break;
      case PackageStatus.OutForDelivery:
        endActivity({
          packageStatus: PackageStatus.Delivered,
          estimatedDeliveryTime: Math.floor(Date.now() / 1000),
        });
        setCurrentStatus(PackageStatus.Delivered);
        break;
      default:
        setCurrentStatus(PackageStatus.Delivered);
        break;
    }
  }

  useEffect(() => {
    const subscription = addOrderCancelEventListener(
      ({ status: newStatus }) => {
        if (newStatus === PackageStatus.Cancelled) {
          endActivity({
            packageStatus: PackageStatus.Cancelled,
            estimatedDeliveryTime: Math.floor(Date.now() / 1000),
          });
          setCurrentStatus(PackageStatus.Cancelled);
        }
      }
    );

    return () => subscription.remove();
  }, []);
  return (
    <View
      style={{
        flex: 1,
        justifyContent: "center",
        alignItems: "center",
      }}
    >
      <Text>iOS Live Activity</Text>

      <Button
        title="Start"
        onPress={() => {
          if (areActivitiesEnabled()) {
            startActivity({
              carrierName: "Fast Shipping Co.",
              trackingNumber: "1Z9999",
              packageStatus: PackageStatus.Shipped,
              estimatedDeliveryTime: Math.floor(Date.now() / 1000),
            });
          }
        }}
      />
      <Button
        title={`Update PackageStatus`}
        onPress={() => updateStatus(currentStatus)}
      />
    </View>
  );
}
